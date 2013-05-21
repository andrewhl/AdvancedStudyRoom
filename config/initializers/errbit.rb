Airbrake.configure do |config|
  config.api_key    = ENV['ASR_ERRBIT_API']
  config.js_api_key = ENV['ASR_ERRBIT_JS_API']
  config.host       = 'errbit.advancedstudyroom.com'
  config.port       = 80
  config.secure     = config.port == 443
end
