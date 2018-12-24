class API::V1::Linimasa::Crowlings::Entities::Crowling < Grape::Entity
  expose :id
  expose :team
  expose :team_text
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
