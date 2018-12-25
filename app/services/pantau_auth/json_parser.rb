module PantauAuth
  class JsonParser < Faraday::Response::Middleware
    def on_complete(env)
      json = MultiJson.load(env[:body], symbolize_keys: true)
      env[:body] = {
        data: json[:data],
        errors: json[:error],
        metadata: json[:meta].present? ? json[:meta] : nil
      }
    end
  end  
end