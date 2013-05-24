require 'rubygems'
require 'digest/sha1'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Add project configurations to environment
require File.expand_path('../../lib/config_reader', __FILE__)
config_reader = ConfigReader.new
config_reader.asr_env_hash.each { |k, c| ENV[k] = c.to_s }
