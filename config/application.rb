require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PokemonApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        if Rails.env.test? || Rails.env.development?
          origins "*"
        else
          origins "*"
          #origins 'waveofweekend.com', 'www.waveofweekend.com'
        end
        resource '*',
                 :headers     => :any,
                 :methods     => [:get, :post, :delete, :put, :patch],
                 :credentials => true,
                 :max_age     => 0
      end
    end
  end
end
