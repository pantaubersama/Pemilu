FactoryBot.define do
  factory :violation_report_reportee, class: 'ViolationReport::Reportee', parent: :violation_report_party do
    association :detail, factory: :violation_report_detail_without_reportee, strategy: :build
    factory :violation_report_reportee_without_detail, traits: [:without_detail]
  end
end
