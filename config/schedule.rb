# Learn more: http://github.com/javan/whenever

every 6.hours do
    rake "db:backup", output: 'log/db-backup.log'
end

every 4.hours do
    rake "manager:import"
    rake "manager:validate"
    rake "manager:tags"
    rake "manager:points"
end


