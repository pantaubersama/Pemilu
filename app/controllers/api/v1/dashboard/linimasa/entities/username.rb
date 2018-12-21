class API::V1::Dashboard::Linimasa::Entities::Username < Grape::Entity
  expose :id
  expose :name
  expose :screen_name do |tw|
      "@#{tw.screen_name}"
  end
  expose :profile_image_url do |tw|
    tw.profile_image_url.to_s
  end
end
