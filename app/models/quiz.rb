class Quiz < ApplicationRecord
  include Publishable
  mount_uploader :image, QuizUploader

  validates_presence_of :title

  has_many :quiz_questions
  has_many :quiz_participations
end
