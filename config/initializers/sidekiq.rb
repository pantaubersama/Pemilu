Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 20
  config.redis = { url: ENV['REDIS_SERVER_URL']}
end

Sidekiq.configure_client do |config|
  config.average_scheduled_poll_interval = 20
  config.redis = { url: ENV['REDIS_CLIENT_URL']}
end
