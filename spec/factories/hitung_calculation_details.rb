FactoryBot.define do
  factory :hitung_calculation_detail, class: 'Hitung::CalculationDetail' do
    hitung_real_count_id { "" }
    hitung_calculation_id { "" }
    actor_type { "MyString" }
    actor_id { "MyString" }
    total_vote { 1 }
  end
end
