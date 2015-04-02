require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WildCompass
  class Application < Rails::Application

    config.time_zone = 'Eastern Time (US & Canada)'

    config.autoload_paths += Dir[[Rails.root, 'lib/**/'].join('/')]
    
  end
end