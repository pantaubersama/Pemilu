class Question < ApplicationRecord
  acts_as_paranoid
  acts_as_votable cacheable_strategy: :update_columns

  validates_length_of :body, minimum: 3, maximum: 260
  validates_presence_of :user_id

  include Reportable
  searchkick

  # "email": null,
  # "first_name": "Yunan",
  # "last_name": "Helmy",
  # "username": null,
  # "avatar": {
  #   "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/badminton.png",
  #   "thumbnail": {
  #     "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/thumbnail_badminton.png"
  #   },
  #   "thumbnail_square": {
  #     "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/thumbnail_square_badminton.png"
  #   },
  #   "medium": {
  #     "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/medium_badminton.png"
  #   },
  #   "medium_square": {
  #     "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/medium_square_badminton.png"
  #   }
  # },
  # "verified": null,
  # "about": "All about me"

  def search_data
    {
      id: self.id,
      cached_votes_up: self.cached_votes_up,
      body: self.body,
      created_at: self.created_at,
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

  def user
    User.find self.user_id
  end
  
end
