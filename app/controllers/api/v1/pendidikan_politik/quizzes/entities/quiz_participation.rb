include ::API::V1::Helpers

module API::V1::PendidikanPolitik::Quizzes::Entities
  class QuizParticipation < API::V1::ApplicationEntity
    expose :id
    expose :status
    # expose :created_at, as: :participated_at, format_with: :friendly_date
    expose :created_at_in_word, as: :participated_at
  end
end
