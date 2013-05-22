require 'yaml'
require 'config_reader'

namespace :db do

  desc "Create a full back of the database"
  task :backup do
    cr = ConfigReader.new
    db = cr.config[:db]
    adapter = db[:adapter]

    if adapter != 'postgres'
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

    asr = cr.config[:asr]
    target = asr[:db_backups] || File.join(cr.root_path, 'tmp')
    target = File.join(target, "#{db[:database]}.gz")

    args << "#{db[:database]}"
    `pg_dump -Fc #{args.join(" ")} | gzip -9 -c > #{target}`
  end

end