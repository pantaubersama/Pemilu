module AuthorizationRequestStubber
  AUTH_BASE_URL   = ENV['AUTH_BASE_URL']
  VERIFY_ENDPOINT = ENV['VERIFY_ENDPOINT']

  DEFAULT_REQUEST_HEADERS = {
      'Accept'          => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'      => 'Ruby'
  }.freeze

  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def stub_credentials_request(access_token:, user: nil, is_admin:, is_eligible:)
    stub_request(:get, "#{AUTH_BASE_URL}#{VERIFY_ENDPOINT}?access_token=#{access_token}").
        with(headers: DEFAULT_REQUEST_HEADERS).
        to_return(
            status:  200,
            body:    {
                         "data": {
                             "info": user&.to_h || {
                                 "id":           "1036fd3c-04ed-4949-b57c-b7dc8ff3e737",
                                 "email":        "namakukingkong@gmail.com",
                                 "full_name":   "Joan Weeks",
                                 "uid":          "6",
                                 "provider":     "identitas",
                                 "is_admin":     is_admin,
                                 "is_moderator": false,
                                 "cluster":      {
                                     "id":          "1882f49d-9de4-4d56-b9f8-5444e494b3f3",
                                     "name":        "Tim Sukses Paslon 1",
                                     "is_eligible": is_eligible
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

  def stub_auth_headers(access_token = SecureRandom.hex, user: nil)
    stub_credentials_request(access_token: access_token, user: user, is_admin: false, is_eligible: false)
    { 'Authorization' => access_token }
  end

  def stub_admin_auth_headers(access_token = SecureRandom.hex)
    stub_credentials_request(access_token: access_token, is_admin: true, is_eligible: false)
    { 'Authorization' => access_token }
  end

  def stub_not_authorized_headers(access_token = SecureRandom.hex)
    stub_credentials_request(access_token: access_token, is_admin: false, is_eligible: false)
    { 'Authorization' => access_token }
  end

  def stub_eligible_auth_headers(access_token = SecureRandom.hex)
    stub_credentials_request(access_token: access_token, is_admin: false, is_eligible: true)
    { 'Authorization' => access_token }
  end
end
