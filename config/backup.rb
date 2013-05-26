# encoding: utf-8

require File.expand_path('../../lib/config_reader', __FILE__)
config_reader = ConfigReader.new
db_config = config_reader.config[:db]
pj_config = config_reader.config[:asr]
bk_config = pj_config[:db_backup]
ml_config = pj_config[:smtp]

##
# $ backup perform -t db_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:db_backup, 'Database backup') do
  split_into_chunks_of 250

  database PostgreSQL do |db|
    db.name               = db_config[:database]
    db.username           = db_config[:username]
    db.password           = db_config[:password]
    db.host               = db_config[:host] || 'localhost'
    db.port               = db_config[:port] || 5432
    db.skip_tables        = []
    db.only_tables        = []
    db.additional_options = ["-xc", "-E=utf8"]
  end

  store_with Dropbox do |db|
    db.api_key     = bk_config[:key]
    db.api_secret  = bk_config[:secret]
    db.access_type = :app_folder
    db.path        = bk_config[:path]
    db.keep        = bk_config[:keep]
  end

  compress_with Gzip

  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = pj_config[:alerts][:sender]
    mail.to                   = pj_config[:alerts][:recipient]
    mail.address              = ml_config[:address]
    mail.port                 = ml_config[:port]
    mail.domain               = ml_config[:domain]
    mail.user_name            = ml_config[:username]
    mail.password             = ml_config[:password]
    mail.authentication       = ml_config[:auth]
    mail.encryption           = :none # :starttls :ssl :tls :none
  end

end
