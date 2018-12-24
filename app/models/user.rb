class User

  # Available methods :
  #
  # .find(id)
  # .full(id)
  # .all.fetch
  # .where(ids: [1,2,3].join(",")).fetch
  #
  #

  include Her::Model
  parse_root_in_json true, format: :active_model_serializers

  def self.full i
    get_raw(:full, id: i) do |parsed, response|
      parsed[:data][:user]
    end
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