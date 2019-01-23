module Publishers
  class JanjiBadge < ApplicationPublisher

    def self.publish message = {}
      # config/initializers/rabbitmq.rb
      # endpoint: Publishers::JanjiBadge.publish message
      #  - exchange: BADGE_JANJI_ACHIEVED
      #  - message:
      #         - {user_id: UUID, badge_code: "your_badge_code", total: 999}

      push BADGE_JANJI_ACHIEVED, message
    end
  end
end