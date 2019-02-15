class Feed < ApplicationRecord
  searchkick  callbacks: :async, 
              text_middle: [:all_fields]
  include Teamable
  acts_as_paranoid

  serialize :source_media
  belongs_to :crowling

  validates :source_id, :source_text, :account_id, :account_name, :account_username, :account_profile_image_url, :crowling_id, :type, presence: true
  validates_uniqueness_of :type, scope: [:source_id, :crowling_id]

  def search_data
    index_all.merge(
      {
        team_source: self.team_source,
        all_fields:  ["--", self.source_text, self.account_name, self.account_username, "--"].compact.join(' ')
      }
    )
  end

  def should_index?
    deleted_at.nil?
  end
end
