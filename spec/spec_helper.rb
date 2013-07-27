# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'pry'
require 'mocha/setup'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'turnip/capybara'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
spec_steps = Dir[Rails.root.join("spec/steps/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
  config.use_transactional_examples = true
  config.include Devise::TestHelpers, type: :controller
  spec_steps.each { |f| config.include File.basename(f, '.rb').classify.pluralize.constantize }
end

Mocha::Configuration.prevent(:stubbing_non_existent_method)
FactoryGirl.duplicate_attribute_assignment_from_initialize_with = false
Capybara.javascript_driver = :poltergeist
