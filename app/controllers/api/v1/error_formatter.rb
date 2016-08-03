module API
  module V1
    module ErrorFormatter
      def self.call message, backtrace, options, env
        begin
          code = env['api.endpoint'].status
        rescue
          code =  500
        end
        {
            error:{
                code: code,
                message:  Rack::Utils::HTTP_STATUS_CODES[code],
                errors: [message]
            }
        }.to_json
      end
    end
  end
end