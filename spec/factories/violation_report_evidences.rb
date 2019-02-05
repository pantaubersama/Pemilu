FactoryBot.define do
  factory :violation_report_evidence, class: 'ViolationReport::Evidence' do
    file { Rack::Test::UploadedFile.new 'spec/images/html.png', 'image/png' }
  end
end
