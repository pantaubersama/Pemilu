module API
  class Init < Grape::API
    # Create log in console
    # insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger, {
    #   logger: Logger.new(STDERR),
    #   filter: Class.new { def filter(opts) opts.reject { |k, _| k.to_s == 'password' } end }.new,
    #   headers: %w(version cache-control)
    # }

    # Build params using object
    include Grape::Extensions::Hashie::Mash::ParamBuilder

    mount API::V1::Main
    #mount API::V2::Main

    # swagger settings
    versions = ["v1", "v2"]
    options = {}
    GrapeSwaggerRails.options.before_action do |request|
      versions.each do |v|
        if URI.parse(request.url).request_uri.eql?("/documentation/#{v}/")
          options = {version: "#{v}"}
          break
        end
      end
      GrapeSwaggerRails.options.app_url            = "/documentation/#{options[:version]}"
      GrapeSwaggerRails.options.url                = "/doc"
      GrapeSwaggerRails.options.hide_url_input     = true
      GrapeSwaggerRails.options.hide_api_key_input = true
    end


  end
end