require 'rails_helper'

describe ViolationReport::Report do
  it { is_expected.to have_one(:detail).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:detail).with_message(:required) }
  it { is_expected.to validate_presence_of(:reporter_id) }
  it { is_expected.to validate_presence_of(:dimension_id) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  describe '.recent' do
    let(:earlier_report) { create :violation_report, created_at: '2000-01-01' }
    let(:recent_report) { create :violation_report, created_at: '2000-01-02' }

    it 'returns records ordered by creation and update time descendingly' do
      expect(described_class.recent).to eq([recent_report, earlier_report])
    end
  end
end
