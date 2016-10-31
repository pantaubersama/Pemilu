module API
  module ErrorFormatter
    def self.call message, backtrace, options, env
      error = if ENV['API_DEBUGGING'].eql?("true")
                {
                  debug:  [backtrace],
                  errors: [message]
                }
              else
                {
                  errors: [message]
                }
              end

      return {
        error: error
      }.to_json
    end
  end
end