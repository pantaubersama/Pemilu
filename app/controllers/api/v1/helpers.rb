module API::V1::Helpers
  extend Grape::API::Helpers
  Grape::Entity.format_with :iso8601 do |date|
    date.iso8601 if date.present?
  end
end