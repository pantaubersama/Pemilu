module API
  module V1
    module Linimasa
      module Crowlings
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Linimasa::Crowlings::Resources::Crowlings
        end
      end
    end
  end
end
