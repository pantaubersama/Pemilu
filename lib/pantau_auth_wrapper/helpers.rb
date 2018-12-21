require 'rack/request'

module PantauAuthWrapper
  module Helpers
    def authenticate_user! access_token
      response = HTTParty.get(PantauAuthWrapper.verify_url, {query: {access_token: access_token}})
      if response.code == 200
        return true
      end
      error!("Invalid token. Your token is expired or revoked", 401) unless current_user
    end

    def current_user
      nil
    end
  end
end