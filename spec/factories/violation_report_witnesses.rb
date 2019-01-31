FactoryBot.define do
  factory :violation_report_witness, class: 'ViolationReport::Witness', parent: :violation_report_party do
    telephone_number { Faker::PhoneNumber.phone_number }
  end
end
