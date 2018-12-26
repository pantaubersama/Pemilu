class API::V1::Dashboard::BannerInfos::Entities::BannerInfo < Grape::Entity
  expose :id
  expose :page_name
  expose :title
  expose :body
  expose :header_image
  expose :image
end
