class Question < ApplicationRecord
  acts_as_paranoid
  acts_as_votable cacheable_strategy: :update_columns

  validates_length_of :body, minimum: 3, maximum: 260
  validates_presence_of :user_id

  include Reportable
  searchkick

  def search_data
    {
      id: self.id,
      cached_votes_up: self.cached_votes_up,
      body: self.body,
      created_at: self.created_at,
      user: {
        id: self.user.id,
        avatar: self.user.avatar,
        first_name: self.user.first_name,
        last_name: self.user.last_name,
        about: self.user.about
      }
    }
  end

  def user
    User.find self.user_id
  end
  
end