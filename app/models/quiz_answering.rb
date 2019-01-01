class QuizAnswering < ApplicationRecord
  include Userable

  belongs_to :quiz_participation
  belongs_to :quiz
  belongs_to :quiz_question
  belongs_to :quiz_answer

  validates :quiz_question, uniqueness: { scope: :quiz_participation }
  
end
