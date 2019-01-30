module API
  module V1
    module Dashboard
      module Linimasa
        module Kenalans
          class Routes < Grape::API
            # Format response
            formatter :json, ::API::SuccessFormatter
            error_formatter :json, ::API::ErrorFormatter

            mount API::V1::Dashboard::Linimasa::Kenalans::Resources::Kenalans
          end
        end
      end
    end
  end
end
