class Quiz < ApplicationRecord
  include Publishable
  mount_uploader :image, QuizUploader

  validates :title, presence: true

  has_many :quiz_questions
  has_many :quiz_participations

  def participate! user_id
    QuizParticipation.where(user_id: user_id, quiz: self).first_or_create! do |q|
      q.status = 0
    end
  end
  
end
