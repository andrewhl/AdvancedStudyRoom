require 'yaml'
require 'rubygems'
require 'active_support/core_ext/hash'

class ConfigReader
  
  attr_reader :config
  attr_accessor :env
  
  def initialize(args = {})
    @env ||= args[:env] || ENV['RAILS_ENV'] || 'production'
    @config = {
      asr: load_yaml('config', 'asr.yml')
      db: load_yaml('config', 'database.yml')}
  end
  
  private
  
    def project_path
      File.join(File.dirname(__FILE__), '..')
    end

    def load_yaml(*args)
      config = YAML.load_file(File.join(project_path, *args))
      config[env].symbolize_keys
    end
  
end