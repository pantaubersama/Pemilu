module Publishers
  class QuestionUpvotingBadge < ApplicationPublisher

    def self.publish message = {}
      # config/initializers/rabbitmq.rb
      # endpoint: Publishers::QuestionBadge.publish BADGE_QUESTION_UPVOTING, message
      #  - exchange: BADGE_QUESTION_UPVOTING
      #  - message:
      #         - {user_id: UUID, badge_code: "your_badge_code", total: 999}

      push BADGE_QUESTION_UPVOTING, message
    end
  end
end