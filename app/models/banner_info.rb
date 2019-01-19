class BannerInfo < ApplicationRecord
  mount_uploader :image, BannerInfoUploader
  mount_uploader :header_image, BannerInfoUploader
  validates :title, :body, :page_name, presence: true
end
