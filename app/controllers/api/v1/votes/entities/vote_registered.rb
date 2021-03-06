module API::V1::Votes::Entities
  class VoteRegistered < Grape::Entity
    expose :status
    expose :text do |o, p|
      o[:status] == true ? "Success" : "Already liked before"
    end
  end
end
