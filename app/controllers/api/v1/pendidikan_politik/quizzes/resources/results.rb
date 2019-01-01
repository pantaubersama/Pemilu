module API::V1::PendidikanPolitik::Quizzes::Resources
  class Results < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "quizzes" do

      desc "Quiz result" do
        detail "Quiz result. <br> It will touch participation (making it in progress if not yet participated)."
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      get "/:id/result" do
        quiz = ::Quiz.published.find params[:id]
        error! "Not found", 404 if quiz.nil?

        participation = quiz.participate! current_user.id
        error! "Quiz is not yet finished", 422 if participation.status != "finished"

        answers = ::QuizAnswer.where(id: ::QuizAnswering.where(quiz_participation: participation).map(&:quiz_answer_id))
          .map(&:team)
        result = ::QuizResult.new(answers, current_user.id).display

        present result
      end

      desc "Quiz summary" do
        detail "Quiz summary. <br> It will touch participation (making it in progress if not yet participated)."
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      get "/:id/summary" do
        quiz = ::Quiz.published.find params[:id]
        error! "Not found", 404 if quiz.nil?

        participation = quiz.participate! current_user.id
        error! "Quiz is not yet finished", 422 if participation.status != "finished"

        questions = quiz.quiz_questions

        present :questions, questions, with: API::V1::PendidikanPolitik::Quizzes::Entities::Result, current_user: current_user
      end

    end
  end
end