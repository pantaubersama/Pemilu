class PoliticalParty < ApplicationRecord
  has_many :candidates, foreign_key: :political_party_id

  mount_uploader :logo, PoliticalPartyUploader
end
