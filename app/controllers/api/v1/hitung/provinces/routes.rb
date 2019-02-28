module API::V1::Hitung::Provinces
  class Routes < Grape::API
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Hitung::Provinces::Resources::Provinces
  end
end
