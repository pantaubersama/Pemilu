module API::V1::Dashboard::UnduhData
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Dashboard::UnduhData::Resources::UnduhData
  end
end
