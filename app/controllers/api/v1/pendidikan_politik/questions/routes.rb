module Api::V1::PendidikanPolitik::Questions
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount Api::V1::PendidikanPolitik::Questions::Resources::Questions
  end
end
