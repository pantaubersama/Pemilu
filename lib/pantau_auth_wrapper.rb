require 'httparty'
require 'grape'

require 'pantau_auth_wrapper/configuration'

require 'pantau_auth_wrapper/oauth2'
require 'pantau_auth_wrapper/extension'
require 'pantau_auth_wrapper/helpers'

require 'pantau_auth_wrapper/base_strategy'
require 'pantau_auth_wrapper/auth_strategies/swagger'
require 'pantau_auth_wrapper/auth_methods/auth_methods'

require 'pantau_auth_wrapper/errors/invalid_token'
require 'pantau_auth_wrapper/errors/invalid_scope'

module PantauAuthWrapper
  extend PantauAuthWrapper::Configuration

  define_setting :url, "http://localhost:4000"
  define_setting :verify_endpoint, "/v1/valid_token/verify"
  define_setting :auth_strategy, "swagger"

  def self.verify_url
    url + verify_endpoint
  end

end