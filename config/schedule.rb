# Learn more: http://github.com/javan/whenever

every 6.hours do
    rake 'db:backup', output: 'log/db-backup.log'
end

every :hour do
    rake 'manager:import'
    rake 'manager:validate'
    rake 'manager:tags'
    rake 'manager:points'
    rake 'manager:points:total'
end
