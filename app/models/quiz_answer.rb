class QuizAnswer < ApplicationRecord
  include Teamable
  
  acts_as_paranoid

  belongs_to :quiz_question

  validates :quiz_question_id, presence: true
end
