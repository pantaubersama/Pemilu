module API
  module V2
    module Config
      extend ActiveSupport::Concern
      included do
        default_format :json
        version "v2", using: :param, parameter: 'v', vendor: 'mnpix'
        format :json
        content_type :json, 'application/json; charset=UTF-8'
        formatter :json, API::SuccessFormatter
        error_formatter :json, API::ErrorFormatter

        rescue_from :all do |e|
          # When required params are missing or validation fails
          if e.class.name == 'Grape::Exceptions::ValidationErrors'
            code    = 406
            message = e.message
            # Bad token
          elsif e.class.name == 'RuntimeError' && e.message == 'Invalid base64 string'
            code    = 406
            message = '401 Unauthorized'
            # Record not found
          elsif e.class.name == ActiveRecord::RecordNotFound
            exceptions_handler(e.message, 404)
            code    = 404
            message = e.message
          else
            code    = 500
            message = e.message
          end
          results = {
            error: {
              code:   code,
              errors: [message]
            }
          }
          Rack::Response.new(results.to_json, code, {"content-type" => "application/json; charset=UTF-8"}).finish
        end
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
