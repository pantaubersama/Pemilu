module API::V1::Hitung::Villages
  class Routes < Grape::API
  formatter :json, ::API::SuccessFormatter
  error_formatter :json, ::API::ErrorFormatter

  mount API::V1::Hitung::Villages::Resources::Villages
  end
end
