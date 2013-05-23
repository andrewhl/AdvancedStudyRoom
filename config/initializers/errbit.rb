Airbrake.configure do |config|
  config.api_key    = ENV['ASR_ERRBIT_APP']
  config.js_api_key = ENV['ASR_ERRBIT_JS']
  config.host       = ENV['ASR_ERRBIT_HOST']
  config.port       = 80
  config.secure     = config.port == 443
end
