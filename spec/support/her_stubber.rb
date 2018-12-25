module HerStubber
  def stub_api_for(klass)
    klass.use_api (api = Her::API.new)

    # Here, you would customize this for your own API (URL, middleware, etc)
    # like you have done in your application’s initializer
    # config/initializers/her.rb
    api.setup url: ENV["AUTH_BASE_URL"] + "/v1" do |c|
      # Request
      c.use PantauAuth::PantauAuthKey
      c.use Faraday::Request::UrlEncoded

      # Response
      c.use PantauAuth::JsonParser

      # Adapter
      # c.use Faraday::Adapter::NetHttp
      c.adapter(:test) { |s| yield(s) }
    end
  end

  def stub_find_user
    stub_api_for(User) do |stub|
      stub.get("https://staging-auth.pantaubersama.com/v1/users/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8") do |env|
        [
          200,
          {},
          {
            "data": {
              "user": {
                "id": "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8",
                "email": "helmy@extrainteger.com",
                "first_name": "Yunan",
                "last_name": "Helmy",
                "username": "yunanhelmy",
                "avatar": {
                  "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/badminton.png",
                  "thumbnail": {
                    "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/thumbnail_badminton.png"
                  },
                  "thumbnail_square": {
                    "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/thumbnail_square_badminton.png"
                  },
                  "medium": {
                    "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/medium_badminton.png"
                  },
                  "medium_square": {
                    "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/medium_square_badminton.png"
                  }
                },
                "verified": false,
                "about": "All about me"
              }
            }
          }.to_json
        ]
      end
    end
  end

  def stub_find_user_2
    stub_api_for(User) do |stub|
      stub.get("https://staging-auth.pantaubersama.com/v1/users/1036fd3c-04ed-4949-b57c-b7dc8ff3e737") do |env|
        [
          200,
          {},
          {
            "data": {
              "user": {
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
                "verified": false,
                "about": nil
              }
            }
          }.to_json
        ]
      end
    end
  end

  def stub_find_users
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
                  "verified": false,
                  "about": nil
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
                  "verified": false,
                  "about": nil
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
  
  
  
end