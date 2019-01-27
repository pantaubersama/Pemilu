require 'elasticsearch/model'
class UserMethods < Hashie::Mash
  def self.class
    self
  end

  def self.primary_key
    "id"
  end
  def self.base_class
    self
  end

  def self.name
    "User"
  end
  def _read_attribute attr
    self.send attr
  end

  def self.polymorphic_name
    "User"
  end
end
class User < Hash
  extend ActiveModel::Naming
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.find(query)
    response = __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query:  query,
            fields: ['id']
          }
        }
      }
    ).first._source
    UserMethods.new(response)
  end
end
