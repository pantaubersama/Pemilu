module Publishers
  class QuizBadge < ApplicationPublisher

    def self.publish message = {}
      # config/initializers/rabbitmq.rb
      # endpoint: Publishers::QuizBadge.publish message
      #  - exchange: BADGE_QUIZ_ACHIEVED
      #  - message:
      #         - {user_id: UUID, badge_code: "your_badge_code", total: 999}

      push BADGE_QUIZ_ACHIEVED, message
    end
  end
end