FactoryBot.define do
  factory :hitung_real_count, class: 'Hitung::RealCount' do
    tps { 1 }
    province_code { 11 }
    regency_code { 1175 }
    district_code { 117505 }
    village_code { 1175052010 }
  end
end
