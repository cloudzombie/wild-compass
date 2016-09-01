require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WildCompass
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Use the responders controller from the responders gem
    # config.app_generators.scaffold_controller :responders_controller

    # rspec
    # config.generators do |g|
    #   g.test_framework :rspec
    # end
    #
    # config.time_zone = 'Eastern Time (US & Canada)'

    # config.autoload_paths += Dir[[Rails.root, 'lib/**/'].join('/')]

    # config.autoload_paths += Dir[[Rails.root, 'app/validators/**/'].join('/')]

  end
end
