class QuizResult
  attr_accessor :result, :user, :participation, :display_answer
  
  def initialize r, u, p, d
    @result = r
    @user = u
    @participation = p
    @display_answer = d
  end

  def display
    res = []
    res = @result if @display_answer == true
    display_simple.merge(answers: res)
      .merge(quiz_participation: decorate_participation)
      .merge(user: decorate_user)
  end

  def decorate_participation
    {
      created_at: @participation.created_at,
      created_at_in_word: @participation.created_at_in_word,
      id: @participation.id,
      status: @participation.status,
      participated_at: @participation.created_at_in_word
    }
  end

  def decorate_user
    {
      id: @user.id,
      email: @user.email,
      full_name: @user.full_name,
      avatar: @user.avatar,
      verified: @user.verified
    }
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
    display_simple.merge(meta_quizzes)
      .merge(user: decorate_user)
  end

  def meta_quizzes
    {
      meta: {
        quizzes: {
          total: Quiz.published.count,
          finished: QuizParticipation.where(user_id: @user.id, status: "finished").count
        }
      }
    }
  end
  
  
end