module API::V1::PendidikanPolitik::Questions::Resources
  class Me < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "me" do

      desc "My Question" do
        detail "My Question"
        headers AUTHORIZATION_HEADERS
      end
      paginate per_page: 25, max_per_page: 100
      oauth2
      get "/questions" do
        questions = Question.where(user_id: current_user.id)
        resources = paginate(questions)
        liked_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: current_user.id, vote_flag: true, vote_scope: nil).map(&:votable_id) if current_user.present?
        reported_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: current_user.id, vote_flag: false, vote_scope: "report").map(&:votable_id) if current_user.present?
        present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question, liked_resources: liked_resources, reported_resources: reported_resources
        present_metas resources
      end

    end
  end
end