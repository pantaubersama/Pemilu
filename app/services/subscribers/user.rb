module Subscribers
  class User
    include Sneakers::Worker
    from_queue "user.changed", env: nil

    def work(data)
      puts "receiving message"
      d = JSON.parse(data)

      # your heave job goes here
      Question.where(user_id: d["id"]).reindex(async: true)
      JanjiPolitik.where(user_id: d["id"]).reindex(async: true)

      puts "reindex success"

      ack! # we need to let queue know that message was received
    end

  end
end
