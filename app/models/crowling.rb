class Crowling < ApplicationRecord
  acts_as_paranoid
  has_many :feeds, dependent: :delete_all
  has_many :tw_timeline_feeds, class_name: 'TwTimelineFeed', dependent: :delete_all

  validates :team, :keywords, presence: true
end