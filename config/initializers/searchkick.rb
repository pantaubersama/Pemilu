Searchkick.redis          = Redis.new url: ENV["REDIS_SERVER_URL"]
Searchkick.client_options = {
  url:              ENV['ELASTICSEARCH_URL'],
  retry_on_failure: true,
  transport_options: { request: { timeout: 250 } },
  log: ENV['LOG_SEARCH'] == 'true'
}

# elastic_auth_config         = {
#   host:              ENV['ELASTICSEARCH_AUTH_URL'],
#   retry_on_failure:  true,
#   transport_options: {
#     request: { timeout: 250 }
#   }
# }
# Elasticsearch::Model.client = Elasticsearch::Client.new(elastic_auth_config)

$auth_elasticsearch_client = Elasticsearch::Client.new(
  url: ENV['ELASTICSEARCH_AUTH_URL'],
  log: ENV['LOG_SEARCH'] == 'true'
)
