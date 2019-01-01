module API::V1::Votes::Entities
  class Unvote < Grape::Entity
    expose :status
    expose :text do |o, p|
      o[:status] == true ? "Success Unlike" : "Already unlike before"
    end
  end
end
