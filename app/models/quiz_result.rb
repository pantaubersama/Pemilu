class QuizResult
  attr_accessor :result, :user_id
  
  def initialize r, u
    @result = r
    @user_id = u
  end

  def display
    display_simple.merge(answers: @result)
  end

  def display_simple
    {
      teams: [
        { 
          id: 1,
          percentage: ((@result.select{|x| x == 1}.size.to_f / @result.size) * 100).round(2)
        },
        { 
          id: 1,
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