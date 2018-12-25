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

  describe "Get users" do
    before do
      stub_api_for(User) do |stub|
        stub.get("https://staging-auth.pantaubersama.com/v1/users") do |env|
          [
            200,
            {},
            {
              "data": {
                "users": [
                  {
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
                  },
                  {
                    "id": "e90ae078-f617-4a32-bcaa-0865041db0e6",
                    "email": "hanifsgy@gmail.com",
                    "first_name": "Hanif",
                    "last_name": "Sugiyanto",
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
                ],
                "meta": {
                  "pages": {
                    "total": 4,
                    "per_page": 2,
                    "page": 1
                  }
                }
              }
            }.to_json
          ]
        end
      end
    end

    it "return users" do
      data = User.all.fetch
      expect(data.size).to eq(2)  
    end
  end
end
