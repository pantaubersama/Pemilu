module API
  module V1
    module Dashboard
      module Linimasa
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Dashboard::Linimasa::Resources::Linimasa
          mount API::V1::Dashboard::Linimasa::Resources::Crowlings
        end
      end
    end
  end
end
