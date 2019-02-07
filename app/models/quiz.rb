class Quiz < ApplicationRecord
  # include Publishable
  enum status: [:draft, :published, :archived]

  mount_uploader :image, QuizUploader

  acts_as_paranoid

  searchkick callbacks:   :async,
             searchable:  [:title, :description],
             word_start:  [:title, :description],
             word_middle: [:title, :description],
             word_end:    [:title, :description],
             word:        [:title, :description]

  validates :title, presence: true

  has_many :quiz_questions
  has_many :quiz_participations

  after_commit :broadcast_new_quiz

  def search_data
    {
      id:                   self.id,
      title:                self.title,
      description:          self.description,
      image:                self.image,
      quiz_questions_count: self.quiz_questions_count,
      created_at:           self.created_at,
      created_at_in_word:   self.created_at_in_word,
    }
  end

  def should_index?
    is_published && deleted_at.nil?
  end


  def participate! user_id
    QuizParticipation.where(user_id: user_id, quiz: self).first_or_create! do |q|
      q.status = 0
    end
  end

  def is_published
    published?
  end

  def create_full_quiz(q, a)
    q.each_with_index do |question, idx|
      q = QuizQuestion.create content: question.content, quiz_id: self.id
      QuizAnswer.create team: 1, content: a[idx].team_1_answer, quiz_question_id: q.id
      QuizAnswer.create team: 2, content: a[idx].team_2_answer, quiz_question_id: q.id
    end
  end

  private

  def broadcast_new_quiz
    if [:published, "published"].include?(status)
      Publishers::QuizNotification.publish "pemilu.quiz", { quiz_id: id, notif_type: :quiz, event_type: :quiz_created }
    end
  end

end
