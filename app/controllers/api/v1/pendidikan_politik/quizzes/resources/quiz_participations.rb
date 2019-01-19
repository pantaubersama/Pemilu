module API::V1::PendidikanPolitik::Quizzes::Resources
  class QuizParticipations < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "quiz_participations" do

      desc "Share Quiz result" do
        detail "Share Quiz result. Need quiz participation ID"
      end
      get "/:quiz_participation_id/result" do
        participation = QuizParticipation.find params.quiz_participation_id
        error! "Quiz participation not found", 404 if participation.nil?
        error! "Quiz is not yet finished", 422 if participation.status != "finished"

        quiz = participation.quiz
        error! "Not found", 404 if quiz.nil?

        answers = ::QuizAnswer.where(id: ::QuizAnswering.where(quiz_participation: participation).map(&:quiz_answer_id))
          .map(&:team)
        result = ::QuizResult.new(answers, participation.user, participation, false).display

        present result
      end

      desc "Quiz total result" do
        detail "Quiz total result. Need user ID"
      end
      params do
        requires :user_id, type: String
      end
      get "/quizzes" do
        u = User.find params.user_id
        error! "Not found", 404 if u.nil?

        participations = ::QuizParticipation.where(user_id: u.id, status: "finished").map(&:id)
        answers = ::QuizAnswer.where(id: ::QuizAnswering.where(quiz_participation: participations).map(&:quiz_answer_id))
          .map(&:team)
        result = ::QuizResult.new(answers, u, nil, false).display_overview

        present result
      end

    end
  end
end