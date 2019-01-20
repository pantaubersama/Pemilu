$redis = Redis.new url: ENV['REDIS_SERVER_URL']

Sneakers.configure(
  amqp: ENV["RABBITMQ_URL"],
  workers: 3,
  daemonize: Rails.env.production? || Rails.env.staging?
)
Sneakers.logger.level = Logger::INFO