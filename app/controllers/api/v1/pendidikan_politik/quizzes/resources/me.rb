module API::V1::PendidikanPolitik::Quizzes::Resources
  class Me < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "me" do

      desc "Quiz total result" do
        detail "Quiz total result"
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      get "/quizzes" do
        participations = ::QuizParticipation.where(user_id: current_user.id, status: "finished").map(&:id)
        answers = ::QuizAnswer.where(id: ::QuizAnswering.where(quiz_participation: participations).map(&:quiz_answer_id))
          .map(&:team)
        result = ::QuizResult.new(answers, current_user, participations, true).display_overview

        present result
      end

    end
  end
end