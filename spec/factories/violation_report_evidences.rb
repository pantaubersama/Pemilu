FactoryBot.define do
  factory :violation_report_evidence, class: 'ViolationReport::Evidence' do
    association :detail, factory: :violation_report_detail_without_evidences, strategy: :build
    file { Rack::Test::UploadedFile.new 'spec/images/html.png', 'image/png' }

    trait :without_detail do
      detail { nil }
    end

    factory :violation_report_evidence_without_detail, traits: [:without_detail]
  end
end
