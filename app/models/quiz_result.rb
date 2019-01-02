class QuizResult
  attr_accessor :result, :user_id
  
  def initialize r, u
    @result = r
    @user_id = u
  end

  def display
    display_simple.merge(answers: @result)
  end

  def team_text team
    [1, "1"].include?(team) ? "Jokowi - Makruf" : "Prabowo - Sandi"
  end

  def team_source team
    {
      id:     team,
      title:  team_text(team),
      avatar: "https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_#{team}.png",
    }
  end

  def display_simple
    {
      teams: [
        { 
          team: team_source(1),
          percentage: ((@result.select{|x| x == 1}.size.to_f / @result.size) * 100).round(2)
        },
        { 
          team: team_source(2),
          percentage: ((@result.select{|x| x == 2}.size.to_f / @result.size) * 100).round(2)
        }
      ]
    }
  end

  def display_overview
    display_simple.merge meta_quizzes
  end

  def meta_quizzes
    {
      meta: {
        quizzes: {
          total: Quiz.published.count,
          finished: QuizParticipation.where(user_id: @user_id, status: "finished").count
        }
      }
    }
  end
  
  
end