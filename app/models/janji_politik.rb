class JanjiPolitik < ApplicationRecord
  mount_uploader :image, JanjiPolitikUploader
  acts_as_paranoid
  has_paper_trail
  validates :title, :body, presence: true
  def user
    @user ||= User.find(self.user_id)
  end
end
