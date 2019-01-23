module Publishers
  class QuestionBadge < ApplicationPublisher

    def self.publish message = {}
      # config/initializers/rabbitmq.rb
      # endpoint: Publishers::QuestionBadge.publish message
      #  - exchange: BADGE_QUESTION_ACHIEVED
      #  - message:
      #         - {user_id: UUID, badge_code: "your_badge_code", total: 999}

      push BADGE_QUESTION_ACHIEVED, message
    end
  end
end