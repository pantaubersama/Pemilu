module API
  class Init < Grape::API
    logger.formatter = GrapeLogging::Formatters::Default.new
    use GrapeLogging::Middleware::RequestLogger, {logger: logger}

    mount API::V1::Main
    mount API::V2::Main
  end
end