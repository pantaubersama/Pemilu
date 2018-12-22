class API::V1::Linimasa::Crowlings::Entities::Crowling < Grape::Entity
  expose :id
  expose :keywords
  expose :team
  expose :team_text
  expose :created_at
  expose :feeds_count do |crowling|
    crowling.feeds.size
  end
end
