class QuizAnswer < ApplicationRecord
  include Teamable

  belongs_to :quiz_question

  validates :quiz_question_id, presence: true
end
