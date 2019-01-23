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
      give_achievement
    end
  end

  def give_achievement
    total = QuizParticipation.where(user_id: user_id, status: :finished).count
    Publishers::QuizBadge.publish({user_id: user_id, badge_code: "kuis", total: total})
  end

end
