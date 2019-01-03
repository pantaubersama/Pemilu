class Feed < ApplicationRecord
  searchkick text_middle: [:all_fields]
  include Teamable
  acts_as_paranoid
  belongs_to :crowling

  validates :source_id, :source_text, :account_id, :account_name, :account_username, :account_profile_image_url, :crowling_id, :type, presence: true
  validates_uniqueness_of :type, scope: [:source_id, :crowling_id]

  def search_data
    {
        id:               self.id,
        source_id:        self.source_id,
        source_text:      self.source_text,

        account_id:       self.account_id,
        account_name:     self.account_name,
        account_username: self.account_username,

        team:             self.team,
        team_source:      self.team_source,
        crowling_id:      self.crowling_id,
        created_at:       self.created_at,
        all_fields:           ["--", self.source_text, self.account_name, self.account_username, "--"].compact.join(' ').downcase
    }
  end
end
