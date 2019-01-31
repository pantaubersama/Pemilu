class API::V1::Dashboard::Linimasa::Kenalans::Entities::UserKenalan < Grape::Entity
  expose :id
  expose :text
  expose :action_at
  expose :is_action
end
