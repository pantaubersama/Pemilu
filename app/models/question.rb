class Question < ApplicationRecord
  acts_as_paranoid

  validates_length_of :body, minimum: 3, maximum: 260
  validates_presence_of :user_id
end
