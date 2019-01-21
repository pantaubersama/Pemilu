require 'rails_helper'

describe ViolationReport::Witness do
  it { is_expected.to validate_presence_of(:telephone_number) }
end
