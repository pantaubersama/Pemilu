class QuizTeam
  attr_accessor :team

  include Teamable

  def initialize team_id
    @team = team_id
  end
  
end