class API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik < Grape::Entity
  expose :id
  expose :title
  expose :body
  expose :created_at
  expose :image
  expose :user, as: :creator, using: API::V1::Users::Entities::User
end
