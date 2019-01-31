class UserCache
  attr_reader :attributes

  def initialize(attributes = {})
    @attributes = attributes
  end

  def to_hash
    @attributes
  end

  def self.find id
    user = UserRepository.new(client: $elastic_model_client).find(id)
    ParseResponse.new(user.attributes)
  end
end
