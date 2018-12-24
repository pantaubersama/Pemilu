class User
  include Her::Model

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
    "voter"
  end

end