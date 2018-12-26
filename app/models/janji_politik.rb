class JanjiPolitik < ApplicationRecord
  acts_as_paranoid
  has_paper_trail
  validates :title, :body, presence: true
end
