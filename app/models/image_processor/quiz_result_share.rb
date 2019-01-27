module ImageProcessor
  class QuizResultShare
    attr_accessor :participation_id, :image_path, :result_path, :image, :quiz_name, :full_name, :team_name, :team_percentage, :team_image, :text1_path

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
        @team_image = Rails.root.to_s + "/public/images/avatar_team_1.png"
      else
        @team_name = result[:teams].select{|x| x[:team][:id] == 2}.last[:team][:title]
        @team_percentage = tim2_percentage
        @team_image = Rails.root.to_s + "/public/images/avatar_team_2.png"
      end
      
      @image_path = Rails.root.to_s + "/public/images/quiz.png"
      @result_path = Rails.root.to_s + "#{tmp_path}/#{@participation_id}.png"
      @image = MiniMagick::Image.open(@image_path)

      @image = text_result
      @image = combine_text_result
      @image = combine_team
      @image = text_team 

      @image.write(@result_path)
      
      remove_composite_images
    end

    def remove_tmp_image
      `rm #{@result_path}`
    end

    def tmp_path
      ENV["QUIZ_RESULT_TMP_PATH"] || "/tmp"
    end
    

    private

    def remove_composite_images
      `rm #{@text1_path}`
    end

    def text_pilihan
      @text1_path = Rails.root.to_s + "#{tmp_path}/text_#{@participation_id}.png"

      convert = MiniMagick::Tool::Convert.new
      convert.font Rails.root.to_s + '/public/fonts/Lato/Lato-Bold.ttf'
      convert.size "700x"
      convert.fill '#7c7c7c'
      convert.pointsize '24'
      convert.gravity 'Center'
      convert << "caption: Dari hasil pilihan #{@quiz_name}\n #{@full_name} lebih suka jawaban dari \n #{@team_name.sub("'", "\\\\'")}"
      convert << @text1_path
      convert.call
    end
    
    def text_result
      @image.combine_options do |c|
        c.font Rails.root.to_s + '/public/fonts/Lato/Lato-Black.ttf'
        c.gravity 'North'
        
        c.fill '#bc071b'
        c.pointsize '44'
        c.draw "text 0, 170 'RESULT'"

        c.font Rails.root.to_s + '/public/fonts/Lato/Lato-Bold.ttf'
        c.fill '#7c7c7c'
        c.pointsize '24'
      end
    end

    def combine_text_result
      text_pilihan
      @image.composite(MiniMagick::Image.new(@text1_path)) do |c|
        c.compose "Over"    
        c.geometry "+0+250"
        c.gravity 'North'
      end
    end
    
    def combine_team
      @image.composite(MiniMagick::Image.new(@team_image)) do |c|
        c.compose "Over"    
        c.geometry "+0+400"
        c.gravity 'North'
      end
    end

    def text_team
      @image.combine_options do |c|
        c.font Rails.root.to_s + '/public/fonts/Lato/Lato-Black.ttf'
        c.gravity 'North'
        
        c.fill '#ffffff'
        c.pointsize '100'
        c.draw "text 0, 750 '#{@team_percentage.round(0)}%'"

        c.pointsize '30'
        c.draw "text 0, 870 '#{@team_name.sub("'", "\\\\'")}'"
      end
    end
    
    
  end
end