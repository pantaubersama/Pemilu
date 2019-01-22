FactoryBot.define do
  factory :violation_report_party, class: 'ViolationReport::Party' do
    name { Faker::Name.name }
    address { Faker::Address.full_address }

    trait :without_detail do
      detail { nil }
    end
  end
end
