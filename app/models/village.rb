class Village < ApplicationRecord
  belongs_to :district, foreign_key: :district_code
end
