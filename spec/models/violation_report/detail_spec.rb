require 'rails_helper'

describe ViolationReport::Detail do
  it { is_expected.to have_one(:reportee).dependent(:delete) }
  it { is_expected.to have_many(:witnesses).dependent(:delete_all) }
  it { is_expected.to have_many(:evidences).dependent(:delete_all) }

  it { is_expected.to validate_presence_of(:report).with_message(:required) }
  it { is_expected.to validate_presence_of(:location) }
  it { is_expected.to validate_presence_of(:occurrence_time) }
  it { is_expected.to validate_presence_of(:witnesses) }
  it { is_expected.to validate_presence_of(:evidences) }
end
