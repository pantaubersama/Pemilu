FactoryBot.define do
  factory :dapil do
    id { 1 }
    nama { "MyString" }
    tingkat { 1 }
    jumlahPenduduk { "MyString" }
    idWilayah { 1 }
    totalAlokasiKursi { 1 }
    idVersi { 1 }
    noDapil { 1 }
    statusCoterminous { false }
    idPro { 1 }
    parent { 1 }
    alokasiKursi { 1 }
    sisaPenduduk { 1 }
    peringkatPenduduk { 1 }
    alokasiSisaKursi { 1 }
    stdDev { "9.99" }
    mean { "9.99" }
    dapilOwner { 1 }
  end
end
