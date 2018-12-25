module HerStubber
  def stub_api_for(klass)
    klass.use_api (api = Her::API.new)

    # Here, you would customize this for your own API (URL, middleware, etc)
    # like you have done in your application’s initializer
    # config/initializers/her.rb
    api.setup url: ENV["AUTH_BASE_URL"] + "/v1" do |c|
      # Request
      c.use PantauAuth::PantauAuthKey
      c.use Faraday::Request::UrlEncoded

      # Response
      c.use PantauAuth::JsonParser

      # Adapter
      # c.use Faraday::Adapter::NetHttp
      c.adapter(:test) { |s| yield(s) }
    end
  end
end