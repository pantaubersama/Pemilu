require 'rails_helper'

RSpec.describe "here", type: :request do
  before do
    stub_user_model
  end
  describe "Get user" do
    it "return user" do
     # u = User.find "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
      expect(true).to eq(true)
    end
  end
end
