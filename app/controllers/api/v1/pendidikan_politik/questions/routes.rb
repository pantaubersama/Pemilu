module Api::V1::PendidikanPolitik::Questions
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::PendidikanPolitik::Questions::Resources::Questions
    mount API::V1::PendidikanPolitik::Questions::Resources::Me
  end
end
