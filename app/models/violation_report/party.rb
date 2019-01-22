class ViolationReport::Party < ApplicationRecord
  belongs_to :detail

  validates :type, presence: true
  validates :name, presence: true
  validates :address, presence: true
end
