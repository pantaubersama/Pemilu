class DapilWilayah < ApplicationRecord
  belongs_to :dapil, foreign_key: :idDapil
end
