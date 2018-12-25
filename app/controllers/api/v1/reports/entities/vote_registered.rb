module API::V1::Reports::Entities
  class VoteRegistered < Grape::Entity
    expose :status
    expose :text do |o, p|
      o[:status] == true ? "Success" : "Already reported before"
    end
  end
end
