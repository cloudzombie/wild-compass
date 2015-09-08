require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WildCompass
  class Application < Rails::Application

    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    config.time_zone = 'Eastern Time (US & Canada)'

    config.autoload_paths += Dir[[Rails.root, 'lib/**/'].join('/')]

    config.autoload_paths += Dir[[Rails.root, 'app/validators/**/'].join('/')]

    # Enable Cross-Origin request
    # config.middleware.insert_before 0, Rack::Cors, logger: Rails.logger do
    #   allow do
    #     origins '*'

    #     resource '*',
    #       headers: "any",
    #       methods: [ :get, :post, :delete, :put, :options, :head ]

    #   end
    # end

  end
end
