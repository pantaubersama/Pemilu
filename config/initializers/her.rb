# config/initializers/her.rb
Her::API.setup url: ENV["AUTH_BASE_URL"] + "/v1" do |c|
  # Request
  c.use PantauAuth::PantauAuthKey
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use PantauAuth::JsonParser

  # Adapter
  c.use Faraday::Adapter::NetHttp
end
