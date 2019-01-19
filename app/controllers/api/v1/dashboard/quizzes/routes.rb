module API
  module V1
    module Dashboard
      module Quizzes
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Dashboard::Quizzes::Resources::Quizzes
          mount API::V1::Dashboard::Quizzes::Resources::Questions
        end
      end
    end
  end
end
