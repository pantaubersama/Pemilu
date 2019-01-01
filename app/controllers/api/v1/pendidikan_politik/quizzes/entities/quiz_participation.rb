include ::API::V1::Helpers

module API::V1::PendidikanPolitik::Quizzes::Entities
  class QuizParticipation < Grape::Entity
    expose :id
    expose :status
    expose :created_at, as: :participated_at, format_with: :friendly_date
  end
end