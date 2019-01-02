class API::V1::Linimasa::Feeds::Entities::Feed < Grape::Entity
  expose :id
  expose :team, with: API::V1::Teams::Entities::Team do |feed|
    feed.team_source
  end
  expose :created_at
  expose :source do
    expose :source_id, as: :id
    expose :source_text, as: :text
  end
  expose :account do
    expose :account_id, as: :id
    expose :account_name, as: :name
    expose :account_username, as: :username
    expose :account_profile_image_url, as: :profile_image_url
  end
end
