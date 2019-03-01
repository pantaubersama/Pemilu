module API::V1::Hitung::Counter
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Hitung::Counter::Resources::Counter
  end
end
