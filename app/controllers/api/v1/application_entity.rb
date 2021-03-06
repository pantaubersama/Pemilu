class API::V1::ApplicationEntity < Grape::Entity
  expose :created_at
  expose :created_at, as: :created_at_in_word, format_with: :friendly_date
end
