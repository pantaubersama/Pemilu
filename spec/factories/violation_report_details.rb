FactoryBot.define do
  factory :violation_report_detail, class: 'ViolationReport::Detail' do
    association :report, factory: :violation_report_without_detail, strategy: :build
    location { Faker::Lorem.sentence }
    occurrence_time { Time.current }
    association :reportee, factory: :violation_report_reportee_without_detail, strategy: :build
    witnesses { build_list :violation_report_witness_without_detail, 1 }
    evidences { build_list :violation_report_evidence_without_detail, 1 }

    trait :without_report do
      report { nil }
    end

    trait :without_witnesses do
      witnesses { [] }
    end

    trait :without_evidences do
      evidences { [] }
    end

    factory :violation_report_detail_without_report, traits: [:without_report]
    factory :violation_report_detail_without_witnesses, traits: [:without_witnesses]
    factory :violation_report_detail_without_evidences, traits: [:without_evidences]
  end
end
