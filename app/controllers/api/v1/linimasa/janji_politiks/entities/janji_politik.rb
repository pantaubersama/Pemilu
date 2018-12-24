class API::V1::Linimasa::JanjiPolitiks::Entities::JanjiPolitik < Grape::Entity
  expose :id
  expose :title
  expose :body
  expose :image
  expose :created_at
end
