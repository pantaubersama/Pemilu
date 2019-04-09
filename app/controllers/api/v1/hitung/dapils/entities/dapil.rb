module API::V1::Hitung::Dapils::Entities
  class Dapil < Grape::Entity
    expose :id
    expose :nama
    expose :tingkat
    expose :jumlahPenduduk
    expose :idWilayah
    expose :totalAlokasiKursi
    expose :idVersi
    expose :noDapil
    expose :statusCoterminous
    expose :idPro
    expose :parent
    expose :alokasiKursi
    expose :sisaPenduduk
    expose :peringkatPenduduk
    expose :alokasiSisaKursi
    expose :stdDev
    expose :mean
    expose :dapilOwner
    expose :maxAlokasiKursi
    expose :minAlokasiKursi
  end
end
