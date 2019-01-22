require 'rails_helper'

describe ViolationReport::Evidence do
  it { expect(subject.file).to be_a(ViolationReportEvidenceFileUploader) }

  it { is_expected.to belong_to(:detail) }

  it { is_expected.to validate_presence_of(:detail).with_message(:required) }
  it { is_expected.to validate_presence_of(:file) }
end
