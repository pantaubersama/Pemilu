class QuizParticipation < ApplicationRecord
  include Userable

  enum status: [ :in_progress, :finished ]

  belongs_to :quiz

  has_many :quiz_answerings
end
