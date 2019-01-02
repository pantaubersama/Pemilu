class QuizQuestion < ApplicationRecord
  belongs_to :quiz, counter_cache: true
  has_many :quiz_answers

  validates :quiz_id, presence: true
end
