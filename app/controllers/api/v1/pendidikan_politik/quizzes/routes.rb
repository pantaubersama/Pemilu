module Api::V1::PendidikanPolitik::Quizzes
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::PendidikanPolitik::Quizzes::Resources::Quizzes
  end
end
