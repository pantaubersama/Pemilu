module API::V1::Dashboard::Quizzes::Entities
  class Question < Grape::Entity
    expose :id
    expose :content
    expose :answers, using: API::V1::Dashboard::Quizzes::Entities::Answer do |obj, opt|
      obj.quiz_answers
    end
  end
end