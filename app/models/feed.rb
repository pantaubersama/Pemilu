class Feed < ApplicationRecord
  include Teamable
  acts_as_paranoid
  belongs_to :crowling

  validates :source_id, :source_text, :account_id, :account_name, :account_username, :account_profile_image_url, :crowling_id, :type, presence: true
  validates_uniqueness_of :type, scope: [:source_id, :crowling_id]
end
