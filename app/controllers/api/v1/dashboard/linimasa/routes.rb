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
          mount API::V1::Dashboard::Linimasa::Kenalans::Routes

          mount API::V1::Lapor::ViolationReports::Resources::Reports
          # mount API::V1::Lapor::ViolationReports::Resources::Reports
        end
      end
    end
  end
end
