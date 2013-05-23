require 'yaml'
require 'rubygems'
require 'active_support/core_ext/hash'

class ConfigReader

  attr_reader :config
  attr_accessor :env

  def initialize(args = {})
    @env ||= args[:env] || ENV['RAILS_ENV'] || 'production'
    @config = {
      asr: load_yaml('config', 'asr.yml'),
      db: load_yaml('config', 'database.yml')}
  end

  def root_path
    File.join(File.dirname(__FILE__), '..')
  end

  def asr_env_hash
    fill_env_hash(config[:asr])
  end

  private

    def fill_env_hash(config_src, target = {}, prefix = nil)
      prefix.concat('_') if prefix && !prefix.end_with?('_')
      config_src.each do |key, value|
        suffix = key.to_s.upcase
        if value.is_a?(Hash)
          fill_env_hash(value, target, suffix)
        else
          target["ASR_#{prefix}#{suffix}"] = value
        end
      end
      target
    end

    def load_yaml(*args)
      config = YAML.load_file(File.join(root_path, *args))
      symbolize_keys!(config[env])
    end

    def symbolize_keys!(hash)
      hash.symbolize_keys!
      hash.values.select{ |v| v.is_a?(Hash) }.each{ |h| symbolize_keys!(h) }
      hash
    end
end