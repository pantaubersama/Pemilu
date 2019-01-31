class UserRepository
  include Elasticsearch::Persistence::Repository
  include Elasticsearch::Persistence::Repository::DSL

  client $auth_elasticsearch_client
  index_name 'user_cache'
  document_type 'user_cache'
  klass User
end
