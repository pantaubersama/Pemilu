require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

require "carrierwave"
require "carrierwave/orm/activerecord"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pemilu
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
    config.active_job.queue_adapter = :sidekiq
    # config.action_mailer.delivery_method = :mailgun
    # config.action_mailer.mailgun_settings = {
    #   api_key: ENV["MAILGUN_API_KEY"],
    #   domain: ENV["MAILGUN_DOMAIN"],
    # }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :user_name => 'cf9b0f106e5055',
      :password => 'fbb3a9f9ca0af1',
      :address => 'smtp.mailtrap.io',
      :domain => 'smtp.mailtrap.io',
      :port => '2525',
      :authentication => :cram_md5
    }
  end
end
