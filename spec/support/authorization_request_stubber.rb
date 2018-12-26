module AuthorizationRequestStubber
  AUTH_BASE_URL   = ENV['AUTH_BASE_URL']
  VERIFY_ENDPOINT = ENV['VERIFY_ENDPOINT']

  DEFAULT_REQUEST_HEADERS = {
      'Accept'          => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'      => 'Ruby'
  }.freeze

  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def stub_credentials_request(access_token:)
    stub_request(:get, "#{AUTH_BASE_URL}#{VERIFY_ENDPOINT}?access_token=#{access_token}").
        with(headers: DEFAULT_REQUEST_HEADERS).
        to_return(
            status:  200,
            body:    {
                         "data": {
                             "info":       {
                                 "id":           "1036fd3c-04ed-4949-b57c-b7dc8ff3e737",
                                 "email":        "namakukingkong@gmail.com",
                                 "first_name":   "Joan",
                                 "last_name":    "Weeks",
                                 "uid":          "6",
                                 "provider":     "identitas",
                                 "is_admin":     false,
                                 "is_moderator": false,
                                 "cluster":      {
                                     "id":          "1882f49d-9de4-4d56-b9f8-5444e494b3f3",
                                     "name":        "Tim Sukses Paslon 1",
                                     "is_eligible": false
                                 }
                             },
                             "credential": {
                                 "access_token":  access_token,
                                 "scopes":        [],
                                 "token_type":    "bearer",
                                 "expires_in":    7200,
                                 "refresh_token": "5ab8d58fd07f349c563c06616d775cef5d100d33581476941a9af5e8e206e470",
                                 "created_at":    1545497467
                             }
                         }
                     }.to_json,
            headers: DEFAULT_RESPONSE_HEADERS
        )
  end

  def auth_token_request(access_token:)
    stub_request(:post, "#{AUTH_BASE_URL}/oauth/token").
        with(headers: {
            'Accept'          => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'    => 'application/x-www-form-urlencoded',
            'User-Agent'      => 'Faraday v0.15.4'
        }, body:      {
            client_id:     "b8bb6b019e79daac5fa8727aa3256f435819fb5d78e5e3b7a421929fc93f80b9",
            client_secret: "33b67f9badee4f134f764da91e43aa9a6bf3bf8b9776fd9148c987b228a1bfc9",
            grant_type:    "client_credentials" }).
        to_return(
            status:  200,
            body:    { "access_token": access_token, "token_type": "Bearer", "expires_in": 7200, "created_at": 1545763047 }.to_json,
            headers: DEFAULT_RESPONSE_HEADERS
        )
  end

  def users_id_request(access_token:)
    stub_request(:get, "#{AUTH_BASE_URL}/v1/users/1036fd3c-04ed-4949-b57c-b7dc8ff3e737").
        with(
            headers: {
                'Accept'          => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization'   => "#{access_token}",
                'User-Agent'      => 'Faraday v0.15.4'
            }).
        to_return(status:   200, body: {
            "data": {
                "user": {
                    "id":         "1036fd3c-04ed-4949-b57c-b7dc8ff3e737",
                    "email":      "namakukingkong@gmail.com",
                    "first_name": "Joan",
                    "last_name":  "Weeks",
                    "username":   nil,
                    "avatar":     {
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
                    "verified":   false,
                    "about":      nil
                }
            }
        }.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end


  def auth_headers(access_token = SecureRandom.hex)
    stub_credentials_request access_token: access_token
    { 'Authorization' => access_token }
  end

  def stub_auth_token(access_token = SecureRandom.hex)
    auth_token_request access_token: access_token
    { 'Authorization' => access_token }

    users_id_request access_token: access_token
    { 'Authorization' => access_token }
  end

  def stub_users_id(access_token = SecureRandom.hex)
    users_id_request access_token: access_token
    { 'Authorization' => access_token }

  end
end
