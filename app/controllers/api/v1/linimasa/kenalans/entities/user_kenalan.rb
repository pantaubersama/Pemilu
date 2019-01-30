class API::V1::Linimasa::Kenalans::Entities::UserKenalan < Grape::Entity
  expose :id
  expose :text
  expose :link
  expose :action_at
  expose :is_action
end
