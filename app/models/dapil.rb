class Dapil < ApplicationRecord
  enum tingkat: [:dpr, :provinsi, :kabupaten]
end
