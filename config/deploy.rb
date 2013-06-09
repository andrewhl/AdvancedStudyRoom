set :application,       'AdvancedStudyRoom'
set :domain,            'web-app@test.advancedstudyroom.com'
set :deploy_to,         '/home/web-app/apps/advanced_study_room'
set :repository,        'https://github.com/andrewhl/AdvancedStudyRoom'
set :revision,          'origin/develop'
set :bundle_cmd,        'bundle'

task :production do
  set :revision,        'origin/master'
  set :domain,          'web-app@beta.advancedstudyroom.com'
end

set :shared_paths, {
  'assets'              => 'public/assets',
  'config/asr.yml'      => 'config/asr.yml',
  'config/database.yml' => 'config/database.yml',
  'config/newrelic.yml' => 'config/newrelic.yml',
  'log'                 => 'log',
  'pids'                => 'tmp/pids',
  'system'              => 'public/system'
}
