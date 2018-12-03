class API::V2::Adventures::Entities::Adventure < Grape::Entity
  expose :id
  expose :title
  expose :created_at do |option|
    Time.zone.now
  end
end
