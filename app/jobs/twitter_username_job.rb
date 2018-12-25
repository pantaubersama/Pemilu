class TwitterUsernameJob < ApplicationJob
  queue_as :timeline

  def perform(*args)
    ts = TwitterService.new(args[0])
    ts.user_timeline
    ts.create!
  end

  def self.runner
    Crowling.all.each do |cr|
      TwitterUsernameJob.perform_now(cr)
    end
  end
end
