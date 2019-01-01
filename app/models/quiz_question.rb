class QuizQuestion < ApplicationRecord
  belongs_to :quiz, counter_cache: true
  has_many :quiz_answers

  validates_presence_of :quiz_id
end
