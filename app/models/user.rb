class User < Hashie::Mash
  include Shared::NonActiveRecordVoter

  def self.repository
    UserRepository.new
  end

  def self.find(id)
    repository.find(id)
  end

  alias_method :attributes, :to_hash

  def save!
    self.class.repository.save self, refresh: true
  end
end
