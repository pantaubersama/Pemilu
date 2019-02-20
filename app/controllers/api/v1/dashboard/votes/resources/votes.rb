module API::V1::Dashboard::Votes::Resources
  class Votes < API::V1::ApplicationResource
    helpers API::V1::Helpers do
      params :votable! do
        requires :id, type: String, desc: 'Votable ID'
        requires :class_name, type: String, values: %w[Question ViolationReport::Report], desc: 'Votable class name'
      end
    end
    before do
      authorize_admin!
    end
    resource "votes" do
      desc "Vote something" do
        headers AUTHORIZATION_HEADERS
        detail "Vote something"
      end
      params do
        use :votable!
        requires :vote_count, type: Integer, desc: "Upvote count"
      end
      oauth2
      post "/" do
        authorize_voter!
        question_must_not_in_folder!
        if params.vote_count < 1
          params.vote_count = 1
        end
        [*1..params.vote_count].map { |i| votable.vote_by voter: current_user, :duplicate => true }
        present :vote, { status: votable.vote_registered? }, with: API::V1::Votes::Entities::VoteRegistered
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
