shared_examples 'a likeable record' do |factory: nil, cache_columns: false|
  subject { create factory } if factory

  it { is_expected.to be_a(ActsAsVotable::Votable) }

  if cache_columns
    it { is_expected.to have_db_column(:cached_votes_total).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_votes_score).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_votes_up).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_votes_down).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_weighted_score).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_weighted_total).of_type(:integer).with_options(default: 0) }
    it { is_expected.to have_db_column(:cached_weighted_average).of_type(:float).with_options(default: 0.0) }
  end

  it 'is uniquely likeable by the same person' do
    subject.liked_by liker
    expect(subject.vote_registered?).to eq(true)

    subject.liked_by liker
    expect(subject.vote_registered?).to eq(false)
  end

  let(:liker) { build :user }
end
