module Userable

  #
  # I expect you to create field `user_id` type `uuid`
  #

  extend ActiveSupport::Concern

  included do
  end

  def user
    @user ||= User.find(self.user_id)
  end


  class_methods do
    
  end
end