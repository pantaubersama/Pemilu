module API::V1::Hitung::Summary
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Hitung::Summary::Resources::Contribution
    mount API::V1::Hitung::Summary::Resources::PresidentList
    mount API::V1::Hitung::Summary::Resources::PresidentDetail
  end
end
