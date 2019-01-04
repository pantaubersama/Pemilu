class Quiz < ApplicationRecord
  include Publishable
  mount_uploader :image, QuizUploader

  searchkick searchable: [:title, :description], 
    word_start: [:title, :description], 
    word_middle: [:title, :description], 
    word_end: [:title, :description], 
    word: [:title, :description]

  validates :title, presence: true

  has_many :quiz_questions
  has_many :quiz_participations

  def search_data
    {
      id: self.id,
      title: self.title,
      description: self.description,
      image: self.image,
      quiz_questions_count: self.quiz_questions_count,
      created_at: self.friendly_date(self.created_at),
    }
  end

  def should_index?
    is_published?
  end
  
  

  def participate! user_id
    QuizParticipation.where(user_id: user_id, quiz: self).first_or_create! do |q|
      q.status = 0
    end
  end
  
end
