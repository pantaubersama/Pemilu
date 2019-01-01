class Quiz < ApplicationRecord
  mount_uploader :image, QuizUploader

  validates_presence_of :title

  has_many :quiz_questions
end
