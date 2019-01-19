class API::V1::Linimasa::Crowlings::Entities::Crowling < API::V1::ApplicationEntity
  expose :id
  expose :team, with: API::V1::Teams::Entities::Team do |feed|
    feed.team_source
  end
  expose :keywords
end
