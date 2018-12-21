require 'pantau_auth_wrapper'

PantauAuthWrapper.setup do |config|
  config.url = ENV["AUTH_BASE_URL"]
  config.verify_endpoint = ENV["VERIFY_ENDPOINT"]
end