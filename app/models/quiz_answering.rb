class QuizAnswering < ApplicationRecord
  include Userable

  acts_as_paranoid

  belongs_to :quiz_participation
  belongs_to :quiz
  belongs_to :quiz_question
  belongs_to :quiz_answer

  validates :quiz_question, uniqueness: { scope: :quiz_participation }
  after_create :set_finished

  private

  def set_finished
    if QuizAnswering.where(user_id: user_id, quiz_participation_id: quiz_participation_id).size == quiz.quiz_questions_count
      quiz_participation.finished!
    end
  end

end
