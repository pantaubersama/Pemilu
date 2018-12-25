class API::V1::Linimasa::Crowlings::Entities::Crowling < Grape::Entity
  expose :id
  expose :team
  expose :team_text
  expose :keywords
  expose :created_at
end
