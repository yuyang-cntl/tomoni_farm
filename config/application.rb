require 'logger'

require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

require "dotenv/load" if Rails.env.production?


module TomoniFarm
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.default_locale = :ja
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Tokyo"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
