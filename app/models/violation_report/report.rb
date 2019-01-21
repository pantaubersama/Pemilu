class ViolationReport::Report < ApplicationRecord
  has_one :detail, dependent: :destroy, required: true

  accepts_nested_attributes_for :detail

  validates :reporter_id, presence: true
  validates :dimension_id, presence: true
  validates :title, presence: true
  validates :description, presence: true

  scope :recent, -> { order created_at: :desc, updated_at: :desc }
end
