class TotalQuizResultImageJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    r = ImageProcessor::TotalQuizResultShare.new(user_id)
    q = QuizPreference.new(user_id: user_id)
    q.image_result = File.open(r.result_path)
    q.save
    r.remove_tmp_image
  end
end
