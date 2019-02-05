require 'rails_helper'

describe ViolationReport::Report do
  it_behaves_like 'a likeable record', factory: :violation_report, cache_columns: true
  it_behaves_like 'a reportable record', factory: :violation_report, cache_columns: true

  it { is_expected.to have_one(:detail).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:detail).with_message(:required) }
  it { is_expected.to validate_presence_of(:reporter_id) }
  it { is_expected.to validate_presence_of(:dimension_id) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  describe '.recent' do
    it 'returns records ordered by creation and update time descendingly' do
      expect(described_class.recent).to eq([recent_report, earlier_report])
    end

    let(:earlier_report) { create :violation_report, created_at: '2000-01-01' }
    let(:recent_report) { create :violation_report, created_at: '2000-01-02' }
  end

  it { is_expected.to delegate_method(:reportee).to(:detail) }

  describe '#reporter' do
    before { subject.reporter_id = reporter.id }

    it { expect(subject.reporter).to eq(reporter) }

    let(:reporter) { create :user }
  end
end
