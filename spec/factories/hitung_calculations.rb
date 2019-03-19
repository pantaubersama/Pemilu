FactoryBot.define do
  factory :hitung_calculation, class: 'Hitung::Calculation' do
    hitung_real_count_id { "" }
    calculation_type { 1 }
    invalid_vote { 1 }
  end
end
