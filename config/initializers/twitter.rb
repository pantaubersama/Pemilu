$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TW_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TW_CONSUMER_SECRET"]
  config.access_token        = ENV["TW_YOUR_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TW_YOUR_ACCESS_SECRET"]
end