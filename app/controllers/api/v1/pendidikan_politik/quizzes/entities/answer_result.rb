module API::V1::PendidikanPolitik::Quizzes::Entities
  class AnswerResult < Grape::Entity
    expose :id
    expose :content
    expose :team
  end
end