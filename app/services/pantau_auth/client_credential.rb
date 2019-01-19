module PantauAuth
  class ClientCredential < Faraday::Middleware
    def call(env)
      client = OAuth2::Client.new(ENV["CONFIDENTIAL_APP_ID"], ENV["CONFIDENTIAL_APP_SECRET"], site: ENV["AUTH_BASE_URL"])
      req = client.client_credentials.get_token
      token = req.token
      env[:request_headers]["Authorization"] = token
      @app.call(env)
    end
  end
end