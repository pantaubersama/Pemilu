include ::API::V1::Helpers

module API::V1::PendidikanPolitik::Questions::Entities
  class Question < API::V1::ApplicationEntity
    expose :temperature
    expose :last_temperature_at
    expose :id
    expose :body, documentation: {type: String, desc: "Question body"}
    # expose :created_at, if: lambda { |c,o| o[:index_version].present? }
    # expose :created_at, format_with: :friendly_date, unless: lambda { |c,o| o[:index_version].present? }
    # expose :created
    expose :cached_votes_up, as: :like_count
    expose :report_count
    expose :user, using: API::V1::PendidikanPolitik::Questions::Entities::User

    expose :is_liked, if: lambda { |c,o| o[:liked_resources].present? } do |obj, opt|
      opt[:liked_resources].include? obj.id
    end
    expose :is_liked, if: lambda { |c,o| o[:liked_resources].nil? || o[:liked_resources].empty? } do |obj, opt|
      false
    end

    expose :is_reported, if: lambda { |c,o| o[:reported_resources].present? } do |obj, opt|
      opt[:reported_resources].include? obj.id
    end
    expose :is_reported, if: lambda { |c,o| o[:reported_resources].nil? || o[:reported_resources].empty? } do |obj, opt|
      false
    end
    expose :share_url
  end
end
