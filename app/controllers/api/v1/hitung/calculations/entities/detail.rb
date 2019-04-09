module API::V1::Hitung::Calculations::Entities
  class Detail < Grape::Entity
    expose :actor_id
    expose :actor_type
    expose :total_vote
  end
end
