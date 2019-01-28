class QuizResultImageJob < ApplicationJob
  queue_as :default

  def perform(quiz_participation_id)
    r = ImageProcessor::QuizResultShare.new(quiz_participation_id)
    q = QuizParticipation.find quiz_participation_id
    q.image_result = File.open(r.result_path)
    q.save
    r.remove_tmp_image

    TotalQuizResultImageJob.perform_later(q.user_id)
  end
end
