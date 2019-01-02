class Kenalan < ApplicationRecord
  has_many :user_kenalans
  validates :text, presence: true
end
