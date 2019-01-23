module API::V1::Users::Resources
  class Questions < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "users" do

      desc "User Question" do
        detail "User Question"
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      get "/:id/questions" do
        user = User.find params.id
        questions = Question.where(user_id: user.id)
        resources = paginate(questions)
        liked_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: user.id, vote_flag: true, vote_scope: nil).map(&:votable_id) if user.present?
        reported_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: user.id, vote_flag: false, vote_scope: "report").map(&:votable_id) if user.present?
        present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question, liked_resources: liked_resources, reported_resources: reported_resources
        present_metas resources
      end

    end
  end
end