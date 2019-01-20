class JanjiPolitik < ApplicationRecord

  searchkick  callbacks: :async, 
              text_middle: [:all_fields]
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

    resluts = {}
    self.column_names.each do |column|
      resluts[column] = self.send(column.to_s)
    end
    resluts.merge({
                    user:       {
                      email:     self.user.try(:email),
                      username:  self.user.try(:username),
                      verified:  self.user.try(:verified),
                      id:        self.user.try(:id),
                      avatar:    self.user.try(:avatar),
                      full_name: self.user.try(:full_name),
                      about:     self.user.try(:about),
                      cluster:   cluster,
                    },
                    all_fields: ["--", self.title, self.body, self.user.try(:username), self.user.try(:full_name), "--"].compact.join(' ')
                  })
  end

  def should_index?
    deleted_at.nil?
  end
end
