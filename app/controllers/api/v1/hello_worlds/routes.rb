module API
  module V1
    module HelloWorlds
      class Routes < Grape::API
        # ReFormat response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::HelloWorlds::Resources::HelloWorlds
      end
    end
  end
end
