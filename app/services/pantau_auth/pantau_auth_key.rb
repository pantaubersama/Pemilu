module PantauAuth
  class PantauAuthKey < Faraday::Middleware
    def call(env)
      env[:request_headers]["PantauAuthKey"] = ENV["PANTAU_AUTH_KEY"]
      @app.call(env)
    end
  end
end