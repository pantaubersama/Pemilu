module API::V1::Votes::Resources
  class Votes < API::V1::ApplicationResource
    helpers API::V1::Helpers do
      params :votable! do
        requires :id, type: String, desc: 'Votable ID'
        requires :class_name, type: String, values: %w[Question ViolationReport::Report], desc: 'Votable class name'
      end
    end

    resource "votes" do
      desc "Vote something" do
        headers AUTHORIZATION_HEADERS
        detail "Vote something"
      end
      params do
        use :votable!
      end
      oauth2
      post "/" do
        question_must_not_in_folder!
        votable.liked_by current_user
        present :vote, { status: votable.vote_registered? }, with: API::V1::Votes::Entities::VoteRegistered
      end

      desc "Unvote something" do
        headers AUTHORIZATION_HEADERS
        detail "Unvote something"
      end
      params do
        use :votable!
      end
      oauth2
      delete "/" do
        error!('Not found', 404) unless votable.votes_for.exists?(voter_id: current_user.id)
        question_must_not_in_folder!
        status = votable.unliked_by(current_user)
        present :vote, { status: status }, with: API::V1::Votes::Entities::Unvote
      end
    end

    helpers do
      def votable
        @votable ||= ::Kernel.const_get(params.class_name).find(params.id)
      end

      def question_must_not_in_folder!
        error!('Pertanyaan sudah terpilih', 404) if votable.is_a?(Question) && votable.question_folder_id.present?
      end
    end
  end
end