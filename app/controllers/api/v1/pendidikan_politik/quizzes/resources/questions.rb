module API::V1::PendidikanPolitik::Quizzes::Resources
  class Questions < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "quizzes" do
      desc "Start a quiz from here." do
        detail "Start / continue a quiz from here. <br> Displaying question list. <br> Question order is randomized. <br> Answer order is randomized. <br> It will touch participation (making it in progress if not yet participated)."
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      get "/:id/questions" do
        quiz = ::Quiz.published.find params[:id]
        
        error! "Not found", 404 if quiz.nil?

        participation = quiz.participate! current_user.id
        answered_questions = QuizAnswering.where(quiz_participation: participation).map(&:quiz_question)

        present :quiz_participation, participation, with: API::V1::PendidikanPolitik::Quizzes::Entities::QuizParticipation
        present :answered_questions, answered_questions, with: API::V1::PendidikanPolitik::Quizzes::Entities::Question
        present :questions, (quiz.quiz_questions.order(Arel.sql("RANDOM()")) - answered_questions), with: API::V1::PendidikanPolitik::Quizzes::Entities::Question
        present :meta, quiz, with: API::V1::PendidikanPolitik::Quizzes::Entities::MetaQuiz, current_user: current_user
      end

      desc "answering questions" do
        detail "answering questions <br> It will touch participation (making it in progress if not yet participated)."
        headers AUTHORIZATION_HEADERS
      end
      params do
        requires :question_id
        requires :answer_id
      end
      oauth2
      post "/:id/questions" do
        quiz = ::Quiz.published.find params[:id]
        error! "Not found", 404 if quiz.nil?
        
        question = quiz.quiz_questions.find params[:question_id]
        error! "Not found", 404 if question.nil?

        answer = question.quiz_answers.find params[:answer_id]
        error! "Not found", 404 if question.nil?

        participation = quiz.participate! current_user.id
        QuizAnswering.create! user_id: current_user.id, quiz_participation: participation, quiz: quiz,
          quiz_question: question, quiz_answer: answer

        if QuizAnswering.where(user_id: current_user.id, quiz_participation: participation).size == quiz.quiz_questions_count
          participation.finished!
        end

        present :quiz_participation, participation, with: API::V1::PendidikanPolitik::Quizzes::Entities::QuizParticipation
        present :meta, quiz, with: API::V1::PendidikanPolitik::Quizzes::Entities::MetaQuiz, current_user: current_user
      end
    end
  end
end