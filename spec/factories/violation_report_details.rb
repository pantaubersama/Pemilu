FactoryBot.define do
  factory :violation_report_detail, class: 'ViolationReport::Detail' do
    location { Faker::Lorem.sentence }
    occurrence_time { Time.current }
    association :reportee, factory: :violation_report_reportee, strategy: :build
    witnesses { build_list :violation_report_witness, 1 }
    evidences { build_list :violation_report_evidence, 1 }
  end
end
