class BannerInfo < ApplicationRecord
  validates :title, :body, :page_name, presence: true
end
