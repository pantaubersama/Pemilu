class QuizAnswer < ApplicationRecord
  include Teamable

  belongs_to :quiz_question

  validates_presence_of :quiz_question_id
end
