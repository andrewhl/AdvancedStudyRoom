source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'haml'
gem 'nokogiri'
gem 'mechanize'
gem 'SgfParser'
gem 'rubyzip', :require => 'zip/zip'
gem 'client_side_validations'
gem 'libv8', '~> 3.11.8'
gem 'cancan'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'less-rails-bootstrap'
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"
gem 'bcrypt-ruby', '~> 3.0.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test do
  # gem 'shoulda'
  # gem 'shoulda-context'
  # gem 'shoulda-matchers'
  # gem 'guard'
  # gem 'spork'
  # gem 'guard-pow'
  # gem 'guard-rspec'
  # gem 'guard-spork'
  gem 'database_cleaner'
end

group :test, :development do
  gem 'rb-inotify', '~> 0.8.8', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'growl'
  gem 'capybara'
  gem 'guard-rspec'

  gem "rspec-rails", "~> 2.0"
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'annotate', ">=2.5.0"
  gem "factory_girl_rails", "~> 3.0"
  gem 'cucumber-rails', :require => false
end

group :production do
  gem 'thin'
  gem 'pg'
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
