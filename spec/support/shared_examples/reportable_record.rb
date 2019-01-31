shared_examples 'a reportable record' do |factory: nil, cache_columns: true|
  subject { create factory } if factory

  it { is_expected.to be_a(Reportable) }

  if cache_columns
    it { is_expected.to have_db_column(:cached_scoped_report_votes_total).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_scoped_report_votes_score).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_scoped_report_votes_up).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_scoped_report_votes_down).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_weighted_report_score).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_weighted_report_total).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_weighted_report_average).of_type(:float).with_options(default: 0.0) }
  end

  it 'is uniquely reportable by the same person' do
    subject.reported_by reporter
    expect(subject.vote_registered?).to eq(true)

    subject.reported_by reporter
    expect(subject.vote_registered?).to eq(false)
  end

  let(:reporter) { build :user }
end
