# Learn more: http://github.com/javan/whenever

every :day, at: '12:00am' do
    rake "db:backup", output: 'log/db-backup.log'
end
