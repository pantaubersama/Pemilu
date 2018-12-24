class API::V1::Linimasa::Feeds::Entities::Feed < Grape::Entity
  expose :id
  expose :team
  expose :team_text
  expose :created_at
  expose :source do
    expose :source_id, as: :id
    expose :source_text, as: :text
  end
  expose :account do
    expose :id
    expose :name
    expose :username
    expose :profile_image_url
  end
end
