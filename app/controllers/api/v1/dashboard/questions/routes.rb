module API
  module V1
    module Dashboard
      module Questions
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Dashboard::Questions::Resources::Questions
        end
      end
    end
  end
end
