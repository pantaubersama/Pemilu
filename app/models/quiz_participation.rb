class QuizParticipation < ApplicationRecord
  include Userable
  
  acts_as_paranoid

  enum status: [ :in_progress, :finished ]

  belongs_to :quiz

  has_many :quiz_answerings
end
