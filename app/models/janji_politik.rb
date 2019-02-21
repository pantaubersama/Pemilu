class JanjiPolitik < ApplicationRecord
  acts_as_paranoid
  searchkick callbacks:   :async,
             text_middle: [:all_fields]

  has_paper_trail
  mount_uploader :image, AssetPictureUploader

  validates :title, :body, presence: true

  after_create :give_achievement

  def give_achievement
    total = JanjiPolitik.where(user_id: user_id).count
    Publishers::JanjiBadge.publish({ user_id: user_id, badge_code: "janji", total: total })
  end

  def user
    User.find(user_id)
  end

  def should_index?
    deleted_at.nil?
  end

  def search_data
    set_user    = self.user
    set_cluster = nil
    cluster_id  = nil
    if set_user.cluster.present?
      set_cluster = set_user.cluster
      cluster_id  = set_user.cluster[:id]
    end
    index_all.merge(
      {
        cluster_id: cluster_id,
        user:       {
          id:        set_user.id,
          email:     set_user.email,
          username:  set_user.username,
          verified:  set_user.verified,
          avatar:    set_user.avatar,
          full_name: set_user.full_name,
          about:     set_user.about,
          cluster:   set_cluster,
        },
        all_fields: ["--", self.title, self.body, set_user.username, set_user.full_name, "--"].compact.join(' ')
      }
    )
  end

  def share_url
    ENV["SHARE_DOMAIN"] + "/share/janjipolitik/" + id
  end
end
