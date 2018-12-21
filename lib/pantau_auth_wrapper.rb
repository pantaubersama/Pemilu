require 'httparty'
require 'grape'
require 'pantau_auth_wrapper/configuration'
require 'pantau_auth_wrapper/oauth2'
require 'pantau_auth_wrapper/extension'
require 'pantau_auth_wrapper/helpers'

module PantauAuthWrapper
  extend PantauAuthWrapper::Configuration

  define_setting :url, "http://localhost:4000"
  define_setting :verify_endpoint, "/v1/valid_token/verify"

  def self.verify_url
    url + verify_endpoint
  end

end