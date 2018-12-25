module API::V1::PendidikanPolitik::Questions::Entities
  class Question < Grape::Entity
    expose :id
    expose :body, documentation: {type: String, desc: "Question body"}
    expose :created_at
    expose :cached_votes_up, as: :like_count
    expose :user, using: API::V1::PendidikanPolitik::Questions::Entities::User
  end
end
