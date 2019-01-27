module ImageProcessor
  class QuizResultShare < ImageProcessor::Quiz
    attr_accessor :participation_id, :quiz_name

    def initialize participation_id
      @participation_id = participation_id
      participation = QuizParticipation.find participation_id
      answers = ::QuizAnswer.where(id: ::QuizAnswering.where(quiz_participation: participation).map(&:quiz_answer_id)).map(&:team)
      result = ::QuizResult.new(answers, participation.user, participation, false).display

      @quiz_name = participation.quiz.title
      @full_name = participation.user.full_name

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
      
      @image_path = Rails.root.to_s + "/public/images/quiz.png"
      @result_path = Rails.root.to_s + "#{tmp_path}/#{@participation_id}.png"
      @image = MiniMagick::Image.open(@image_path)

      text_pilihan "Dari hasil pilihan #{@quiz_name}\n #{@full_name} lebih suka jawaban dari \n #{@team_name.sub("'", "\\\\'")}"
      @image = text_result
      @image = combine_text_result
      @image = combine_team
      @image = text_team 

      @image.write(@result_path)
      
      remove_composite_images
    end

    def tmp_path
      ENV["QUIZ_RESULT_TMP_PATH"] || "/tmp"
    end
    
  end
end