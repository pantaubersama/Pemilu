require 'elasticsearch/persistence'
class Repository
  include Elasticsearch::Persistence::Repository

  def create(params)
    save(params, refresh: true)
  end

end
