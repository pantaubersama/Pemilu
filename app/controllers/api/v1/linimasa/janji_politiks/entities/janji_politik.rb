class API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik < API::V1::ApplicationEntity
  expose :id
  expose :title
  expose :body
  expose :image
  expose :user, as: :creator, using: API::V1::Users::Entities::User
  expose :share_url
end
