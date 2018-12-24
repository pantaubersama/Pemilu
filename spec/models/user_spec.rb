require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Get user" do
    before do
      stub_find_user_2
    end

    it "return user" do
      u = User.find "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
      expect(u.first_name).to eq("Joan")  
    end
  end

  describe "Get users" do
    before do
      stub_find_users
    end

    it "return users" do
      data = User.all.fetch
      expect(data.size).to eq(2)
    end
  end
end
