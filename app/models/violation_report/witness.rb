class ViolationReport::Witness < ViolationReport::Party
  validates :telephone_number, presence: true
end
