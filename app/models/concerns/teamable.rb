module Teamable

  #
  # I expect you to create field `team` type `integer`
  #

  extend ActiveSupport::Concern

  included do
    validates :team, presence: true
  end


  def team_text
    [1, "1"].include?(team) ? "Jokowi - Ma'ruf" : "Prabowo - Sandi"
  end

  def team_source
    {
        id:     team,
        title:  team_text,
        avatar: "https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_#{team}.png",
    }
  end


  class_methods do

  end
end
