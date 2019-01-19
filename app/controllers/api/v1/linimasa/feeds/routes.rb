module API
  module V1
    module Linimasa
      module Feeds
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Linimasa::Feeds::Resources::Feeds
        end
      end
    end
  end
end
