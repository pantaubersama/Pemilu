class Question < ApplicationRecord
  acts_as_paranoid
  acts_as_votable

  validates_length_of :body, minimum: 3, maximum: 260
  validates :user_id, presence: true

  include Reportable
  searchkick searchable: [:body], word_start: [:body], word_middle: [:body], word_end: [:body], word: [:body]

  include API::V1::Helpers

  belongs_to :question_folder, optional: true

  scope :in_folder, -> { where.not(question_folder_id: nil) }
  scope :not_in_folder, -> { where(question_folder_id: nil) }


  def should_index?
    deleted_at.nil? && question_folder_id.nil?
  end

  def search_data
    {
      id:                 self.id,
      cached_votes_up:    self.cached_votes_up,
      body:               self.body,
      created_at:         self.created_at,
      created_at_in_word: self.created_at_in_word,
      user:               {
        email:     self.user.email,
        username:  self.user.username,
        verified:  self.user.verified,
        id:        self.user.id,
        avatar:    self.user.avatar,
        full_name: self.user.full_name,
        about:     self.user.about,
      }
    }
  end

  # def created
  #   created_at
  # end


  def user
    User.find self.user_id
  end

end
