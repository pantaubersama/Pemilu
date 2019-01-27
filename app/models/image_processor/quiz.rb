module ImageProcessor
  class Quiz
    attr_accessor :image_path, :result_path, :image, :full_name, :team_name, :team_percentage, :team_image, :text1_path
    
    def remove_tmp_image
      `rm #{@result_path}`
    end

    def tmp_path
      "/tmp"
    end

    def remove_composite_images
      `rm #{@text1_path}`
    end

    def avatar_team_1
      Rails.root.to_s + "/public/images/avatar_team_1.png"
    end

    def avatar_team_2
      Rails.root.to_s + "/public/images/avatar_team_2.png"
    end
    
    

    # image manipulation

    def text_pilihan fulltext
      @text1_path = Rails.root.to_s + "#{tmp_path}/text_#{@participation_id}.png"

      convert = MiniMagick::Tool::Convert.new
      convert.font Rails.root.to_s + '/public/fonts/Lato/Lato-Bold.ttf'
      convert.size "700x"
      convert.fill '#7c7c7c'
      convert.pointsize '24'
      convert.gravity 'Center'
      convert << 'caption: ' + fulltext
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

    def combine_text_result
      @image.composite(MiniMagick::Image.new(@text1_path)) do |c|
        c.compose "Over"    
        c.geometry "+0+250"
        c.gravity 'North'
      end
    end

  end
end