Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    credentials = false
    if Rails.env.test? || Rails.env.development?
      credentials = false
      origins "*"
    else
      origins "*"
      #origins 'waveofweekend.com', 'www.waveofweekend.com'
    end
    resource '*',
             :headers     => :any,
             :methods     => [:get, :post, :delete, :put],
             :credentials => credentials,
             :max_age     => 0
  end
end

# Read more: https://github.com/cyu/rack-cors

# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'example.com'
#
#     resource '*',
#       headers: :any,
#       methods: [:get, :post, :put, :patch, :delete, :options, :head]
#   end
# end
