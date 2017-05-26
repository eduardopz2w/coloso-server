require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Coloso
  class Application < Rails::Application
    ActiveModelSerializers.config.adapter = :json_api
    ActiveModelSerializers.config.key_transform = :camel_lower
    config.autoload_paths << "#{Rails.root}/app/errors"
    config.autoload_paths << "#{Rails.root}/app/riot"
    config.assets.enabled = false
    config.middleware.use Rack::MethodOverride
    config.i18n.default_locale = 'en'
    config.androidMinApkVersion = ENV['COLOSO_MIN_APK_VERSION']
    config.androidActualApkVersion = ENV['COLOSO_ACTUAL_APK_VERSION']

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
