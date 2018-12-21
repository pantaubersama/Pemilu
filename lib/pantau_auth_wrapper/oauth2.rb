require 'rack/auth/abstract/request'

module PantauAuthWrapper
  class Oauth2 < Grape::Middleware::Base
    attr_reader :auth_strategy

    def context
      env['api.endpoint']
    end

    def the_request=(env)
      @_the_request = ActionDispatch::Request.new(env)
    end

    def request
      @_the_request
    end

    def token
      token = if request.headers["Authorization"].present?
        request.headers["Authorization"].include?("bearer") ? request.headers["Authorization"].try("split", "bearer").try(:last).try(:strip) : request.headers["Authorization"]
      else
        request.parameters["access_token"]
      end
    end
    

    ############
    # Authorization control.
    ############

    def endpoint_protected?
      auth_strategy.endpoint_protected?
    end

    def auth_scopes
      return *nil unless auth_strategy.has_auth_scopes?
      auth_strategy.auth_scopes
    end

    def authorize!(*scopes)
      response = HTTParty.get(PantauAuthWrapper.verify_url, {query: {access_token: token}})
      if response.code == 200
        scopes = response.parsed_response["data"]["credential"]["scopes"]
        unless auth_strategy.auth_scopes & scopes == auth_strategy.auth_scopes
          raise PantauAuthWrapper::Errors::InvalidScope
        end
        return true
      end
      raise PantauAuthWrapper::Errors::InvalidToken
    end
    
    ############
    # Grape middleware methods
    ############

    def before
      set_auth_strategy(PantauAuthWrapper.auth_strategy)
      auth_strategy.api_context = context
      context.extend(PantauAuthWrapper::AuthMethods)

      context.protected_endpoint = endpoint_protected?
      return unless context.protected_endpoint?

      self.the_request = env
      authorize!(*auth_scopes)
    end


    private

    def set_auth_strategy(strategy)
      @auth_strategy = PantauAuthWrapper::AuthStrategies.const_get(strategy.to_s.capitalize.to_s).new
    end
    
    
  end
end
