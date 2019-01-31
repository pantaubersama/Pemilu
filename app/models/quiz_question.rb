class QuizQuestion < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :quiz, counter_cache: true
  has_many :quiz_answers

  validates :quiz_id, presence: true
  
  after_create :reindex_quiz
  after_destroy :reindex_quiz

  def reindex_quiz
    quiz.reindex
  end

end
