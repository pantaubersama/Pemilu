$redis = Redis.new

Sneakers.configure(amqp: ENV["RABBITMQ_URL"])
Sneakers.logger.level = Logger::INFO