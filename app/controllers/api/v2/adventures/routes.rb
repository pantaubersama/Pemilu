module API
  module V2
    module Adventures
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V2::Adventures::Resources::Adventures
      end
    end
  end
end
