module API::V1::PendidikanPolitik::Quizzes::Entities
  class MetaQuiz < Grape::Entity
    expose :quizzes do
      expose :quiz_questions_count
      expose :answered_questions_count do |obj, opt|
        ::QuizAnswering.where(quiz: obj.id, quiz_participation_id: opt[:quiz_participation_id], user_id: opt[:current_user].id).count
      end
    end
  end
end
