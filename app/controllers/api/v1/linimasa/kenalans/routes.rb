module API
  module V1
    module Linimasa
      module Kenalans
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Linimasa::Kenalans::Resources::Kenalans
        end
      end
    end
  end
end
