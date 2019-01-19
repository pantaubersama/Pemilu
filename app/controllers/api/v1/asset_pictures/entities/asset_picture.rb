class API::V1::AssetPictures::Entities::AssetPicture < Grape::Entity
  expose :id
  expose :picture
  expose :bucket_title
end