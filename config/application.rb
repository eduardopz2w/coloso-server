require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Coloso
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    ActiveModelSerializers.config.adapter = :json_api
    ActiveModelSerializers.config.key_transform = :camel_lower
    config.autoload_paths << "#{Rails.root}/app/errors"
    config.autoload_paths << "#{Rails.root}/app/riot"
    config.api_only = true
  end
end
