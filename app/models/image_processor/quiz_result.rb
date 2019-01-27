module ImageProcessor
  class QuizResult

    def initialize participation_id
      participation = QuizParticipation.find participation_id
      answers = ::QuizAnswer.where(id: ::QuizAnswering.where(quiz_participation: participation).map(&:quiz_answer_id)).map(&:team)
      result = ::QuizResult.new(answers, participation.user, participation, false).display

      quiz_name = participation.quiz.title
      full_name = participation.user.full_name

      tim1_percentage = result[:teams].select{|x| x[:team][:id] == 1}.last[:percentage]
      tim2_percentage = result[:teams].select{|x| x[:team][:id] == 2}.last[:percentage]

      if tim1_percentage > tim2_percentage
        team_name = result[:teams].select{|x| x[:team][:id] == 1}.last[:team][:title]
        team_percentage = tim1_percentage
        team_image = Rails.root.to_s + "/public/images/avatar_team_1.png"
      else
        team_name = result[:teams].select{|x| x[:team][:id] == 2}.last[:team][:title]
        team_percentage = tim2_percentage
        team_image = Rails.root.to_s + "/public/images/avatar_team_2.png"
      end

      text1_path = text1('Dari hasil pilihan ' + quiz_name, full_name, "lebih suka jawaban dari \n" + team_name)
      
      image = MiniMagick::Image.open(Rails.root.to_s + "/public/images/quiz.png")

      image.combine_options do |c|
        c.font Rails.root.to_s + '/public/fonts/Lato/Lato-Black.ttf'
        c.gravity 'North'
        
        c.fill '#bc071b'
        c.pointsize '44'
        c.draw "text 0, 170 'RESULT'"

        c.font Rails.root.to_s + '/public/fonts/Lato/Lato-Bold.ttf'
        c.fill '#7c7c7c'
        c.pointsize '24'
      end

      image = image.composite(MiniMagick::Image.new(text1_path)) do |c|
        c.compose "Over"    
        c.geometry "+0+250"
        c.gravity 'North'
      end

      image = image.composite(MiniMagick::Image.new(team_image)) do |c|
        c.compose "Over"    
        c.geometry "+0+380"
        c.gravity 'North'
      end

      image.write(Rails.root.to_s + "/public/images/result.png")
    end

    def text1 text1, text2, text3
      convert = MiniMagick::Tool::Convert.new
      convert.font Rails.root.to_s + '/public/fonts/Lato/Lato-Bold.ttf'
      convert.size "700x"
      convert.fill '#7c7c7c'
      convert.pointsize '24'
      convert.gravity 'Center'
      convert << "caption: #{text1}\n #{text2} #{text3}"
      convert << Rails.root.to_s + "/public/images/text.png"
      convert.call

      Rails.root.to_s + "/public/images/text.png"
    end
    

    
  end
end