FactoryBot.use_parent_strategy = false

FactoryBot.define do
  factory :hitung_real_count, class: 'Hitung::RealCount' do
    tps { 1 }
    province_code { 34 }
    regency_code { 3401 }
    district_code { 340101 }
    village_code { 3401012001 }
    # association :province, code: 34, strategy: :build
    # association :regency, code: 3401, province_id: 34, strategy: :build
    # association :district, code: 340101, regency_code: 3401, strategy: :build
    # association :village, code: 3401012001, district_code: 340101, strategy: :build
  end
end
