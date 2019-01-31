FactoryBot.define do
  factory :violation_report_party, class: 'ViolationReport::Party' do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
  end
end
