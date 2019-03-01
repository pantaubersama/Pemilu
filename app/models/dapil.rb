class Dapil < ApplicationRecord
  enum tingkat: [:dpr, :provinsi, :kabupaten, :dpd]

  has_many :dapil_wilayahs, foreign_key: :idWilayah
end
