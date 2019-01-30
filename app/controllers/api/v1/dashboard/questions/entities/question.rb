module API::V1::Dashboard::Questions::Entities
  class Question < Grape::Entity
    expose :id
    expose :content
    expose :answers, using: API::V1::PendidikanPolitik::Quizzes::Entities::AnswerOption do |obj, opt|
      obj.quiz_answers
    end
  end
end