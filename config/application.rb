require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module AdvancedStudyRoom
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 2.hours }

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # TODO: refactor security to .... I DON'T KNOW. STOP ASKING ME. GOD.
    config.active_record.whitelist_attributes = false

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { host: ENV['ASR_SMTP_DOMAIN'] }
    config.action_mailer.smtp_settings = {
      :address              => ENV['ASR_SMTP_ADDRESS'],
      :port                 => ENV['ASR_SMTP_PORT'],
      :domain               => ENV['ASR_SMTP_DOMAIN'],
      :user_name            => ENV['ASR_SMTP_USERNAME'],
      :password             => ENV['ASR_SMTP_PASSWORD'],
      :authentication       => ENV['ASR_SMTP_AUTH'],
      :enable_starttls_auto => ENV['ASR_SMTP_STARTTLS_AUTO'] == 'true' }
    # TODO: Add mail interceptor unless Rails.env.production?

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.generators do |g|
      g.template_engine :haml

      # you can also specify a different test framework or ORM here
      # g.test_framework  :rspec
      # g.orm             :mongoid

    end

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
