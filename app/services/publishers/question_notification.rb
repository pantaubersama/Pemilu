module Publishers
  class QuestionNotification < ApplicationPublisher

    def self.publish exchange, message = {}
      # endpoint: Publishers::QuestionNotification.publish exchange, message
      #  - exchange: "pemilu.question"
      #  - message:
      #         - {question_id: UUID, count: 100, notif_type: :question, event_type: :upvote_report }
      #         - {question_id: UUID, receiver_id: UUID, user_action_id: UUID, notif_type: :question, event_type: :upvote }
      push exchange, message
    end
  end
end
