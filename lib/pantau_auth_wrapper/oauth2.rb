module PantauAuthWrapper
  class Oauth2 < Grape::Middleware::Base
    def call(env)
      @app.call(env)
    end
  end
end
