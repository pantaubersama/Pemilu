module API
  class Init < Grape::API
    mount API::V2::Main
    mount API::V1::Main

    # swagger settings

    GrapeSwaggerRails.options.before_filter do |request|
      if URI.parse(request.url).request_uri.eql?("/documentation/v1/")
        options = {version: "v1"}
      else
        options = {version: "v2"}
      end
      GrapeSwaggerRails.options.app_url            = "/documentation/#{options[:version]}"
      GrapeSwaggerRails.options.url                = "/doc"
      GrapeSwaggerRails.options.hide_url_input     = true
      GrapeSwaggerRails.options.hide_api_key_input = true
      GrapeSwaggerRails.options.headers            = {'Accept-Version' => "#{options[:version]}"}
    end


  end
end