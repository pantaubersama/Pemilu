module API::V1::Hitung::Districts
  class Routes < Grape::API
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Hitung::Districts::Resources::Districts
  end
end
