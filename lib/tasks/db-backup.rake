require 'yaml'
require 'config_reader'
require 'fileutils'

namespace :db do

  desc "Rollover the database backups and create a new full backup"
  task :backup do
    config_file = File.expand_path('../../../config/backup.rb', __FILE__)
    exec "backup perform -t db_backup -c #{config_file}"
  end

end