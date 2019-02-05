module API::V1::Dashboard::Quizzes::Entities
  class Answer < Grape::Entity
    expose :id
    expose :content
    expose :team
  end
end