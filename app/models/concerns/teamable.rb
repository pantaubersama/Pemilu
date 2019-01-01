module Teamable
  
  #
  # I expect you to create field `team` type `integer`
  #

  extend ActiveSupport::Concern

  included do
    validates_presence_of :team
  end


  def team_text
    [1, "1"].include?(team) ? "Jokowi - Makruf" : "Prabowo - Sandi"
  end


  class_methods do
    
  end
end