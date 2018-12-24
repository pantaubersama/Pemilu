class Crowling < ApplicationRecord
  has_many :feeds, dependent: :delete_all
  has_many :tw_timeline_feeds, class_name: 'TwTimelineFeed', dependent: :delete_all

  def team_text
    [1, "1"].include?(team) ? "Jokowi - Makruf" : "Prabowo - Sandi"
  end

  def trash
    only_deleted
  end
end