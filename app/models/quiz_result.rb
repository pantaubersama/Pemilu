class QuizResult
  attr_accessor :result, :user, :participation, :display_answer

  def initialize r, u, p, d
    @result         = r
    @user           = u
    @participation  = p
    @display_answer = d
  end

  def display
    res = []
    res = @result if @display_answer == true
    display_simple.merge(answers: res)
      .merge(quiz_participation: decorate_participation)
      .merge(user: decorate_user)
      .merge(quiz: decorate_quiz)
  end

  def decorate_participation
    {
      created_at:         @participation.created_at,
      created_at_in_word: @participation.created_at_in_word,
      id:                 @participation.id,
      status:             @participation.status,
      participated_at:    @participation.created_at_in_word,
      image_result:       @participation.image_result,
    }
  end

  def decorate_user
    {
      id:        @user.id,
      email:     @user.email,
      full_name: @user.full_name,
      avatar:    @user.avatar,
      verified:  @user.verified
    }
  end

  def decorate_quiz
    {
      id:                   @participation.quiz.id,
      title:                @participation.quiz.title,
      description:          @participation.quiz.description,
      image:                @participation.quiz.image,
      quiz_questions_count: @participation.quiz.quiz_questions_count
    }
  end


  def team_text team
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

  def team_source team
    {
      id:     team,
      title:  team_text(team),
      avatar: "https://s3-ap-southeast-1.amazonaws.com/pantau-bersama/assets/teams/avatar_team_#{team}.jpg",
    }
  end

  def display_simple
    {
      teams: [
               {
                 team:       team_source(1),
                 percentage: ((@result.select { |x| x == 1 }.size.to_f / @result.size) * 100).round(2)
               },
               {
                 team:       team_source(2),
                 percentage: ((@result.select { |x| x == 2 }.size.to_f / @result.size) * 100).round(2)
               }
             ]
    }
  end

  def display_overview
    display_simple.merge(meta_quizzes)
      .merge(decorate_quiz_preference)
      .merge(user: decorate_user)
  end

  def decorate_quiz_preference
    quiz_preference = QuizPreference.where(user_id: @user.id).order("created_at desc").first
    {
      quiz_preference: {
        id: quiz_preference.try(:id),
        image_result: quiz_preference.try(:image_result)
      }
    }
  end
  

  def meta_quizzes
    {
      meta: {
        quizzes: {
          total:    Quiz.published.count,
          finished: QuizParticipation.where(user_id: @user.id, status: "finished").count
        }
      }
    }
  end


end
