module API
  module V1
    module Config
      extend ActiveSupport::Concern
      included do
        default_format :json
        version "v1", using: :accept_version_header, vendor: 'mnpix'
        format :json
        content_type :json, 'application/json; charset=UTF-8'
        formatter :json, API::SuccessFormatter
        error_formatter :json, API::ErrorFormatter

        rescue_from :all
        helpers do
          include ActionController::HttpAuthentication::Token
          def me
            @me
          end

          def token
            token_params_from(headers['Authorization']).shift[1]
          end

          def logger
            Rails.logger
          end


        end
      end
    end
  end
end
