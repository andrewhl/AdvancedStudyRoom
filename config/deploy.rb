set :application,       'AdvancedStudyRoom'
set :rails_env,         'staging'
set :domain,            'web-app@asr.guzart.com'
set :deploy_to,         '/home/web-app/apps/advanced_study_room'
set :repository,        'https://github.com/andrewhl/AdvancedStudyRoom'
set :revision,          'origin/develop'
set :bundle_cmd,        'bundle'

task :production do
  set :rails_env,       'production'
  set :domain,          'web-app@beta.advancedstudyroom.com'
  set :revision,        'origin/master'
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
