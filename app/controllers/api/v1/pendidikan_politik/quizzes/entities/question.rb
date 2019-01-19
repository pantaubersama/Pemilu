module API::V1::PendidikanPolitik::Quizzes::Entities
  class Question < Grape::Entity
    expose :id
    expose :content
    expose :answers, using: API::V1::PendidikanPolitik::Quizzes::Entities::AnswerOption do |obj, opt|
      obj.quiz_answers.order(Arel.sql("RANDOM()"))
    end
  end
end