require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Get user" do
    before do
      stub_api_for(User) do |stub|
        stub.get("https://staging-auth.pantaubersama.com/v1/users/1036fd3c-04ed-4949-b57c-b7dc8ff3e737") do |env|
          [
            200,
            {},
            {
              "data": {
                "id": "1036fd3c-04ed-4949-b57c-b7dc8ff3e737",
                "email": "namakukingkong@gmail.com",
                "first_name": "Joan",
                "last_name": "Weeks",
                "username": nil,
                "avatar": {
                  "url": nil,
                  "thumbnail": {
                    "url": nil
                  },
                  "thumbnail_square": {
                    "url": nil
                  },
                  "medium": {
                    "url": nil
                  },
                  "medium_square": {
                    "url": nil
                  }
                },
                "verified": false
              }
            }.to_json
          ]
        end
      end
    end

    it "return user" do
      u = User.find "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
      expect(u.first_name).to eq("Joan")  
    end
  end
end
