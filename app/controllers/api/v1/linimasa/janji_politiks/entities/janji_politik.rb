class API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik < Grape::Entity
  expose :id
  expose :title
  expose :body
  expose :created_at
  expose :user, using: API::V1::Users::Entities::User
end
