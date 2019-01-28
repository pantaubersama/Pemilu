class ParseResponse < Hashie::Mash
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
class User < UserCache
end
