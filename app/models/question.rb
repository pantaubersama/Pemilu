class Question < ApplicationRecord
  acts_as_paranoid
  acts_as_votable

  validates_length_of :body, minimum: 3, maximum: 260
  validates_presence_of :user_id

  include Reportable
  searchkick

  include API::V1::Helpers

  belongs_to :question_folder, optional: true
  
  scope :in_folder, -> { where.not(question_folder_id: nil) }
  scope :not_in_folder, -> { where(question_folder_id: nil) }

  def search_data
    {
      id: self.id,
      cached_votes_up: self.cached_votes_up,
      body: self.body,
      created: self.created,
      created_at: self.friendly_date(self.created_at),
      user: {
        email: self.user.email,
        username: self.user.username,
        verified: self.user.verified,
        id: self.user.id,
        avatar: self.user.avatar,
        first_name: self.user.first_name,
        last_name: self.user.last_name,
        about: self.user.about,
      }
    }
  end

  def created
    created_at
  end
  

  def user
    User.find self.user_id
  end

end
