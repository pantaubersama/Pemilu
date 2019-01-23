module Subscribers
  class User
    include Sneakers::Worker
    from_queue QUEUE_USER_CHANGED, env: nil

    def work(data)
      logger.info "Subscribers::User receiving message #{data}"
      d = JSON.parse(data)

      # your heave job goes here
      Question.where(user_id: d["id"]).reindex(async: true)
      JanjiPolitik.where(user_id: d["id"]).reindex(async: true)

      logger.info "Subscribers::User reindex success #{data}"

      ack! # we need to let queue know that message was received
    end

  end
end
