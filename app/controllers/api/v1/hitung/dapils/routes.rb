module API::V1::Hitung::Dapils
  class Routes < Grape::API
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Hitung::Dapils::Resources::Dapils
  end
end
