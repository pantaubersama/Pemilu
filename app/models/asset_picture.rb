class AssetPicture < ApplicationRecord
  mount_uploader :picture, AssetPictureUploader
  validates :bucket_title, :picture, presence: true
end
