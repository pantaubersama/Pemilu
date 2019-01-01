module API::V1::Votes::Resources
  class Votes < API::V1::ApplicationResource
    helpers API::V1::Helpers

    resource "votes" do
      desc "Vote something" do
        headers AUTHORIZATION_HEADERS
        detail "Vote something"
      end
      params do
        requires :id, type: String, desc: "ID"
        requires :class_name, type: String, desc: "Your class name", documentation: {default: "Question"}
      end
      oauth2
      post "/" do
        klass = ::Kernel.const_get(params.class_name)
        q = klass.send(:find, params.id)
        q.liked_by current_user
        present :vote, {status: q.vote_registered?}, with: API::V1::Votes::Entities::VoteRegistered
      end


      desc "Unvote something" do
        headers AUTHORIZATION_HEADERS
        detail "Unvote something"
      end
      params do
        requires :id, type: String, desc: "ID"
        requires :class_name, type: String, desc: "Your class name", documentation: {default: "Question"}
      end
      oauth2
      delete "/" do
        klass = ::Kernel.const_get(params.class_name)
        q = klass.send(:find, params.id)
        vote = q.votes_for.find_by voter_id: current_user.id
        error! "Not found", 404 if vote.nil?
        status = vote.destroy! 
        present :vote, {status: status.destroyed?}, with: API::V1::Votes::Entities::Unvote
      end
    end
  end
end