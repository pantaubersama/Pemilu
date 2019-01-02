class Kenalan < ApplicationRecord
  has_many :user_kenalans
  validates_presence_of :text
end
