class JanjiPolitik < ApplicationRecord
  validates :title, :body, presence: true
end
