# Learn more: http://github.com/javan/whenever
# http://en.wikipedia.org/wiki/Cron

every '40 0,6,12,18 * * *' do
  rake 'db:backup', output: 'log/db-backup.log'
end

every :hour do
  rake 'manager:all'
end
