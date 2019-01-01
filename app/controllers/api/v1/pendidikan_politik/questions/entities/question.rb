include ::API::V1::Helpers

module API::V1::PendidikanPolitik::Questions::Entities
  class Question < Grape::Entity
    expose :id
    expose :body, documentation: {type: String, desc: "Question body"}
    expose :created_at, if: lambda { |c,o| o[:index_version].present? }
    expose :created_at, format_with: :friendly_date, unless: lambda { |c,o| o[:index_version].present? }
    expose :created
    expose :cached_votes_up, as: :like_count
    expose :user, using: API::V1::PendidikanPolitik::Questions::Entities::User
    expose :is_liked, if: lambda { |c,o| o[:liked_resources].present? } do |obj, opt|
      opt[:liked_resources].include? obj.id
    end
    expose :is_liked, if: lambda { |c,o| o[:liked_resources].nil? } do |obj, opt|
      false
    end
  end
end
