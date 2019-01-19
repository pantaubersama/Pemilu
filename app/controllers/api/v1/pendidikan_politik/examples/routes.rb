module API::V1::PendidikanPolitik::Examples
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::PendidikanPolitik::Examples::Resources::Examples
  end
end
