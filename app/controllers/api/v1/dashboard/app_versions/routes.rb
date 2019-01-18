module API
  module V1
    module Dashboard
      module AppVersions
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Dashboard::AppVersions::Resources::LastVersion
          mount API::V1::Dashboard::AppVersions::Resources::AppVersions
        end
      end
    end
  end
end
