include ::API::V1::Helpers

module API::V1::PendidikanPolitik::Questions::Entities
  class Question < Grape::Entity
    expose :id
    expose :body, documentation: {type: String, desc: "Question body"}
    expose :created_at, if: lambda { |c,o| o[:index_version].present? }
    expose :created_at, format_with: :friendly_date, unless: lambda { |c,o| o[:index_version].present? }
    expose :cached_votes_up, as: :like_count
    expose :user, using: API::V1::PendidikanPolitik::Questions::Entities::User
  end
end
