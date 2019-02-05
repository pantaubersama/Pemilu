module API::V1::Lapor::ViolationReports
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Lapor::ViolationReports::Resources::Reports
    mount API::V1::Lapor::ViolationReports::Resources::Me
  end
end
