module API
  class InitPendidikanPolitik< Grape::API
    # Create log in console
    #if ENV['API_DEBUGGING'].eql?("true")
    insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger, {
        logger:  Logger.new(STDERR),
        filter:  Class.new {
          def filter(opts)
            opts.reject { |k, _| k.to_s == 'password' }
          end }.new,
        headers: %w(version cache-control)
    }
    #end
    # Build params using object
    include Grape::Extensions::Hashie::Mash::ParamBuilder

    # pantau auth wrapper
    use ::PantauAuthWrapper::Oauth2
    helpers ::PantauAuthWrapper::Helpers

    # rescue invalid token
    rescue_from PantauAuthWrapper::Errors::InvalidToken do |e|
      error!(e, 401)
    end
    rescue_from PantauAuthWrapper::Errors::InvalidScope do |e|
      error!(e, 401)
    end

    mount API::V1::MainPendidikanPolitik

    GrapeSwaggerRails.options.app_url            = "/pendidikan_politik/v1/doc"
    GrapeSwaggerRails.options.url                = "/api"
    GrapeSwaggerRails.options.hide_url_input     = false
    GrapeSwaggerRails.options.hide_api_key_input = true
  end
end