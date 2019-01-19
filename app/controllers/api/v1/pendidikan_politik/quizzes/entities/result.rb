module API::V1::PendidikanPolitik::Quizzes::Entities
  class Result < Grape::Entity
    expose :id
    expose :content
    expose :quiz_answers, as: :answers, with: API::V1::PendidikanPolitik::Quizzes::Entities::AnswerResult
    expose :answered, with: API::V1::PendidikanPolitik::Quizzes::Entities::AnswerResult  do |obj, opt|
      QuizAnswering.where(user_id: opt[:current_user].id, quiz_id: obj.quiz_id, quiz_question_id: obj.id).last.quiz_answer
    end
  end
end