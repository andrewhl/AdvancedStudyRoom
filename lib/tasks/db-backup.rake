require 'yaml'
require 'config_reader'
require 'fileutils'

namespace :db do

  desc "Rollover the database backups and create a new full backup"
  task :backup do
    %w(db:backup:rollover db:backup:full).each do |task|
      Rake::Task[task].invoke
    end
  end

  namespace :backup do
    desc "Rollover the database backup files"
    task :rollover do
      next unless rollover.to_i <= 0 || File.exists?(target_file)

      last_file = "#{target_file}.#{rollover - 1}"
      FileUtils.rm(last_file) if File.exists?(last_file)

      index = rollover - 2
      while index >= 0 do
        src = rollover_file(index)
        FileUtils.mv(src, rollover_file(index + 1)) if File.exists?(src)
        index -= 1
      end
    end

    desc "Create a full backup of the database"
    task :full do
      db = config_reader.config[:db]
      if db[:adapter] != 'postgresql'
        $stderr << 'db:backup is only available for Postgresql databases'
        exit 1
      end
      
      args = []
      host = db[:host] || 'localhost'
      args << "-h '#{host}'"
      port = db[:port] || '5432'
      args << "-p #{port}"

      uname = db[:username]
      args << "-U #{uname}" if uname
      pword = db[:password]
      ENV['PGPASSWORD'] = pword if pword

      args << "#{db[:database]}"
      `pg_dump -Fc #{args.join(" ")} | gzip -9 -c > #{target_file}`
    end
  end

  private

    def config_reader
      @config_reader = ConfigReader.new
    end

    def target_path
      config_reader.config[:asr][:db_backups] || File.join(config_reader.root_path, 'tmp')
    end

    def target_file
      File.join(target_path, "#{config_reader.config[:db][:database]}.gz")
    end

    def rollover
      config_reader.config[:asr][:db_rollback] || 7
    end

    def rollover_file(index)
      return target_file if index == 0
      "#{target_file}.#{index}"
    end

end