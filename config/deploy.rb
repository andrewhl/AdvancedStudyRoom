set :application, "AdvancedStudyRoom"
set :domain, "web-app@beta.advancedstudyroom.com"
set :deploy_to, "/home/web-app/apps/advanced_study_room"
set :repository, 'https://github.com/andrewhl/AdvancedStudyRoom'
set :revision, "origin/master"

set :shared_paths, {
  'assets'              => 'public/assets',
  'config/asr.yml'      => 'config/asr.yml',
  'config/database.yml' => 'config/database.yml',
  'config/newrelic.yml' => 'config/newrelic.yml',
  'log'                 => 'log',
  'pids'                => 'tmp/pids',
  'system'              => 'public/system'
}
