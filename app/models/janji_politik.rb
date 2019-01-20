class JanjiPolitik < ApplicationRecord

  searchkick text_middle: [:all_fields]
  acts_as_paranoid
  has_paper_trail
  mount_uploader :image, AssetPictureUploader

  validates :title, :body, presence: true

  def user
    @user ||= User.find(self.user_id)
  end

  def search_data
    cluster = nil
    if self.user.present? && self.user.cluster.present?
      cluster = self.user.cluster
    end

    index_all.merge(
      {
        user:       {
          id:        self.user.id,
          email:     self.user.email,
          username:  self.user.username,
          verified:  self.user.verified,
          avatar:    self.user.avatar,
          full_name: self.user.full_name,
          about:     self.user.about,
          cluster:   cluster,
        },
        all_fields: ["--", self.title, self.body, self.user.username, self.user.full_name, "--"].compact.join(' ')
      }
    )
  end

  def should_index?
    deleted_at.nil?
  end
end
