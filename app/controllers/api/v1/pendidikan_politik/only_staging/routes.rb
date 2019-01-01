module API::V1::PendidikanPolitik::OnlyStaging
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::PendidikanPolitik::OnlyStaging::Resources::Quiz
  end
end
