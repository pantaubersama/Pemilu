require 'sneakers'

$redis = Redis.new url: ENV['REDIS_SERVER_URL']

Sneakers.configure(
  amqp: ENV["RABBITMQ_URL"],
  daemonize: Rails.env.production? || Rails.env.staging?,
  workers: ENV["SNEAKERS_WORKERS_COUNT"],
  log: ENV["SNEAKERS_LOG_FILE"],
  pid_path: ENV["SNEAKERS_PID_FILE"]
)

Sneakers.logger.level = Logger::INFO