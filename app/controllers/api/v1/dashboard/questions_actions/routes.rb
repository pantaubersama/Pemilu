module API::V1::Dashboard::QuestionsActions
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Dashboard::QuestionsActions::Resources::Questions
  end
end
