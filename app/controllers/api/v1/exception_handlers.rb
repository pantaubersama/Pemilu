module API
  module V1
    module ExceptionHandlers
      def self.included(base)
        base.instance_eval do
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
        end
      end
    end
  end
end
