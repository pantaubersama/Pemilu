module API
  module V1
    module Linimasa
      module BannerInfos
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Linimasa::BannerInfos::Resources::BannerInfos
        end
      end
    end
  end
end
