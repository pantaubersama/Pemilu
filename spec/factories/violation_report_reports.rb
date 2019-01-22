FactoryBot.define do
  factory :violation_report, class: 'ViolationReport::Report' do
    reporter_id { SecureRandom.uuid }
    dimension_id { SecureRandom.uuid }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    association :detail, factory: :violation_report_detail_without_report, strategy: :build
  end
end
