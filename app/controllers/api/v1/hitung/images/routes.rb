module API::V1::Hitung::Images
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Hitung::Images::Resources::Images
  end
end
