require 'rails_helper'

describe ViolationReport::Party do
  it { is_expected.to belong_to(:detail) }

  it { is_expected.to validate_presence_of(:detail).with_message(:required) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
end
