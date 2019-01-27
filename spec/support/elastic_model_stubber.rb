module ElasticModelStubber

  USER_ALAM     = {
    "user": {
      "id":        "1036fd3c-04ed-4949-b57c-b7dc8ff3e737",
      "email":     "namakukingkong@gmail.com",
      "full_name": "Joan Weeks",
      "username":  nil,
      "avatar":    {
        "url":              nil,
        "thumbnail":        {
          "url": nil
        },
        "thumbnail_square": {
          "url": nil
        },
        "medium":           {
          "url": nil
        },
        "medium_square":    {
          "url": nil
        }
      },
      "verified":  false,
      "cluster":   nil,
      "about":     nil
    }
  }.freeze
  USER_HELMY    = {
    "user": {
      "id":        "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8",
      "email":     "helmy@extrainteger.com",
      "full_name": "Yunan Helmy",
      "username":  "yunanhelmy",
      "avatar":    {
        "url":              "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/badminton.png",
        "thumbnail":        {
          "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/thumbnail_badminton.png"
        },
        "thumbnail_square": {
          "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/thumbnail_square_badminton.png"
        },
        "medium":           {
          "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/medium_badminton.png"
        },
        "medium_square":    {
          "url": "https://pantau-test.s3.amazonaws.com/uploads/user/avatar/c9242c5a-805b-4ef5-b3a7-2a7f25785cc8/medium_square_badminton.png"
        }
      },
      "verified":  false,
      "cluster":   nil,
      "about":     "All about me"
    }
  }.freeze
  USER_HANIF    = {
    "id":        "e90ae078-f617-4a32-bcaa-0865041db0e6",
    "email":     "hanifsgy@gmail.com",
    "full_name": "Hanif Sugiyanto",
    "username":  nil,
    "avatar":    {
      "url":              nil,
      "thumbnail":        {
        "url": nil
      },
      "thumbnail_square": {
        "url": nil
      },
      "medium":           {
        "url": nil
      },
      "medium_square":    {
        "url": nil
      }
    },
    "verified":  false,
    "cluster":   nil,
    "about":     nil
  }.freeze

  def stub_user_model
    repository = Repository.new(index_name: :users, klass: User)
    repository.create(USER_ALAM)
    repository.create(USER_HELMY)
    repository.create(USER_HANIF)
  end
end
