class RequestDatum < ApplicationRecord
  validates :email, presence: true
end
