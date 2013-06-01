# Learn more: http://github.com/javan/whenever

every 6.hours do
    rake "db:backup", output: 'log/db-backup.log'
end

