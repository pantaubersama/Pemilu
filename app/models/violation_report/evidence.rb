class ViolationReport::Evidence < ApplicationRecord
  mount_uploader :file, ViolationReportEvidenceFileUploader

  belongs_to :detail

  validates :file, presence: true
end
