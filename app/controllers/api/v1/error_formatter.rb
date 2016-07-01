module API
  module V1
    module ErrorFormatter
      def self.call message, backtrace, options, env
        {
            error:{
                code: env['api.endpoint'].status,
                message:  Rack::Utils::HTTP_STATUS_CODES[env['api.endpoint'].status],
                errors: [message]
            }
        }.to_json
      end
    end
  end
end