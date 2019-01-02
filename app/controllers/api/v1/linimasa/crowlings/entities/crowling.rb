class API::V1::Linimasa::Crowlings::Entities::Crowling < Grape::Entity
  expose :id
  expose :team, with: API::V1::Teams::Entities::Team do |feed|
    feed.team_source
  end
  expose :keywords
  expose :created_at
end
