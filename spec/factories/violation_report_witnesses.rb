FactoryBot.define do
  factory :violation_report_witness, class: 'ViolationReport::Witness', parent: :violation_report_party do
    association :detail, factory: :violation_report_detail_without_witnesses, strategy: :build
    telephone_number { Faker::PhoneNumber.phone_number }

    factory :violation_report_witness_without_detail, traits: [:without_detail]
  end
end
