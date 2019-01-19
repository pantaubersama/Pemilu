module API
  module V1
    module Dashboard
      module BannerInfos
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Dashboard::BannerInfos::Resources::BannerInfos
        end
      end
    end
  end
end
