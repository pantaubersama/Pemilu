module API::V1::PendidikanPolitik::Quizzes::Entities
  class AnswerOption < Grape::Entity
    expose :id
    expose :content
  end
end