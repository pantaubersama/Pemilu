FactoryBot.define do
  factory :violation_report, class: 'ViolationReport::Report' do
    reporter_id { SecureRandom.uuid }
    dimension_id { SecureRandom.uuid }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    association :detail, factory: :violation_report_detail, strategy: :build

    # Note: This should be the last trait in the list so `reindex` is called
    # after all the other callbacks complete.
    trait :reindex do
      after :create do |report, _evaluator|
        report.reindex refresh: true
      end
    end
  end
end
