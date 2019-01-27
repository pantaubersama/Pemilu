module ImageProcessor
  class TotalQuizResultShare < ImageProcessor::Quiz
    attr_accessor :user_id

    def tmp_path
      ENV["TOTAL_QUIZ_RESULT_TMP_PATH"] || "/tmp"
    end    

    def initialize user_id
      @user_id = user_id
      user = User.find @user_id

      participations = ::QuizParticipation.where(user_id: user_id, status: "finished").map(&:id)
      answers = ::QuizAnswer.where(id: ::QuizAnswering.where(quiz_participation: participations).map(&:quiz_answer_id))
        .map(&:team)
      result = ::QuizResult.new(answers, user, nil, false).display_overview

      @full_name = user.full_name
      @total = result[:meta][:quizzes][:total]
      @finished = result[:meta][:quizzes][:finished]

      tim1_percentage = result[:teams].select{|x| x[:team][:id] == 1}.last[:percentage]
      tim2_percentage = result[:teams].select{|x| x[:team][:id] == 2}.last[:percentage]

      if tim1_percentage > tim2_percentage
        @team_name = result[:teams].select{|x| x[:team][:id] == 1}.last[:team][:title]
        @team_percentage = tim1_percentage
        @team_image = avatar_team_1
      else
        @team_name = result[:teams].select{|x| x[:team][:id] == 2}.last[:team][:title]
        @team_percentage = tim2_percentage
        @team_image = avatar_team_2
      end

      @image_path = Rails.root.to_s + "/public/images/quiz_total.png"
      @result_path = Rails.root.to_s + "#{tmp_path}/#{@user_id}.png"
      @image = MiniMagick::Image.open(@image_path)

      text_pilihan "Total kecenderungan #{@finished} dari #{@total} Kuis,\n #{@full_name} lebih suka jawaban dari \n #{@team_name.sub("'", "\\\\'")}"
      @image = text_result
      @image = combine_text_result
      @image = combine_team
      @image = text_team 

      @image.write(@result_path)
      
      remove_composite_images
    end

  end
end