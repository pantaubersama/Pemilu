module Teamable

  #
  # I expect you to create field `team` type `integer`
  #

  extend ActiveSupport::Concern

  included do
    validates :team, presence: true
  end


  def team_text
    if [1, "1"].include?(team)
      "Tim Jokowi - Ma'ruf"
    elsif [2, "2"].include?(team)
      "Tim Prabowo - Sandi"
    elsif [3, "3"].include?(team)
      "KPU"
    elsif [4, "4"].include?(team)
      "Bawaslu"
    end
  end

  def team_source
    {
        id:     team,
        title:  team_text,
        avatar: "https://s3-ap-southeast-1.amazonaws.com/pantau-bersama/assets/teams/avatar_team_#{team}.jpg",
    }
  end


  class_methods do

  end
end
