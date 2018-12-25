class User
  include Her::Model
  parse_root_in_json true, format: :active_model_serializers

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