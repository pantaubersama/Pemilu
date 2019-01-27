require 'elasticsearch/model'

class User < Hashie::Mash
  extend ActiveModel::Naming
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.find(id)
    response = __elasticsearch__.search(query: { multi_match: { query: id, fields: ['id'] } })
    new(response.first._source)
  end

  def self.class
    self
  end

  def self.base_class
    self
  end

  def self.name
    'User'
  end

  def self.polymorphic_name
    'User'
  end

  def self.primary_key
    'id'
  end

  def _read_attribute attr
    self.send attr
  end
end
