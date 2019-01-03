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
    cluster_id = nil
    if self.user.present? && self.user.cluster.present?
      cluster_id = self.user.cluster[:id]
    end
    {
        id:         self.id,
        title:      self.title,
        body:       self.body,
        created_at: self.created_at,
        updated_at: self.updated_at,
        user:       {
            email:      self.user.email,
            username:   self.user.username,
            verified:   self.user.verified,
            id:         self.user.id,
            avatar:     self.user.avatar,
            full_name:  self.user.full_name,
            about:      self.user.about,
            cluster:    cluster_id,
        },
        all_fields: ["--", self.title, self.body, self.user.username, "--"].compact.join(' ').downcase

    }
  end
end
