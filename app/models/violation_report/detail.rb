class ViolationReport::Detail < ApplicationRecord
  belongs_to :report
  has_one :reportee, dependent: :delete, required: true
  has_many :witnesses, dependent: :delete_all
  has_many :evidences, dependent: :delete_all

  accepts_nested_attributes_for :reportee
  accepts_nested_attributes_for :witnesses
  accepts_nested_attributes_for :evidences

  validates :location, presence: true
  validates :occurrence_time, presence: true
  validates :witnesses, presence: true
  validates :evidences, presence: true
end
