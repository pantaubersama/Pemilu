require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::JanjiPolitiks", type: :request do
  before do
    stub_find_user
    @access_token = SecureRandom.hex
  end
  describe "[GET] Endpoint /janji_politiks" do
    before do
      create :janji_politik, title: "Pengadaan Bunker Anti Bencana", body: "Pada 2019, di wacanakan bunker anti bencana siap di resmikan."
      JanjiPolitik.reindex
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/janji_politiks", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:janji_politiks].size).to eq(1)
      expect(json_response[:data][:janji_politiks].first[:body]).to eq("Pada 2019, di wacanakan bunker anti bencana siap di resmikan.")
      expect(json_response[:data][:janji_politiks].first[:title]).to eq("Pengadaan Bunker Anti Bencana")
      expect(json_response[:data][:janji_politiks].first[:creator][:id]).to eq("1036fd3c-04ed-4949-b57c-b7dc8ff3e737")
      expect(json_response[:data][:janji_politiks].first[:creator][:email]).to eq("namakukingkong@gmail.com")
      expect(json_response[:data][:janji_politiks].first[:creator][:full_name]).to eq("Joan Weeks")
      expect(response.status).to eq(200)
    end
  end
  describe "[GET] Endpoint /janji_politiks/:id" do
    before do
      @janji_politik = create :janji_politik, title: "Pengadaan Bunker Anti Bencana", body: "Pada 2019, di wacanakan bunker anti bencana siap di resmikan."
      JanjiPolitik.reindex
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/janji_politiks/#{@janji_politik.id}", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:janji_politik][:body]).to eq("Pada 2019, di wacanakan bunker anti bencana siap di resmikan.")
      expect(json_response[:data][:janji_politik][:title]).to eq("Pengadaan Bunker Anti Bencana")
      expect(json_response[:data][:janji_politik][:creator][:id]).to eq("1036fd3c-04ed-4949-b57c-b7dc8ff3e737")
      expect(json_response[:data][:janji_politik][:creator][:email]).to eq("namakukingkong@gmail.com")
      expect(json_response[:data][:janji_politik][:creator][:full_name]).to eq("Joan Weeks")
      expect(response.status).to eq(200)
    end
  end
  describe "[GET] Endpoint /janji_politiks/me" do
    before do
      3.times do
        create :janji_politik, user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
      end
      2.times do
        create :janji_politik, user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
      end
      JanjiPolitik.reindex
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/janji_politiks/me", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:janji_politiks].size).to eq(3)
      expect(json_response[:data][:janji_politiks].first[:body]).to eq("Pada 2019, di wacanakan bunker anti bencana siap di resmikan.")
      expect(json_response[:data][:janji_politiks].first[:title]).to eq("Pengadaan Bunker Anti Bencana")
      expect(json_response[:data][:janji_politiks].first[:creator][:id]).to eq("1036fd3c-04ed-4949-b57c-b7dc8ff3e737")
      expect(json_response[:data][:janji_politiks].first[:creator][:email]).to eq("namakukingkong@gmail.com")
      expect(json_response[:data][:janji_politiks].first[:creator][:full_name]).to eq("Joan Weeks")
      expect(response.status).to eq(200)
    end
  end

  describe "[GET] Endpoint /janji_politiks [using filter]" do
    before do
      create :janji_politik, title: "Pembahasan pengadaan pesawat anti kapal selam", body: "Di gosipkan akan di adakan acara hura hura."
      4.times do
        create :janji_politik
      end
      JanjiPolitik.reindex
    end
    it "filter by user_verified_true" do
      get "/linimasa/v1/janji_politiks", params: { filter_by: :user_verified_true }
      expect(json_response[:data][:janji_politiks].size).to eq(0)
    end

    it "filter by user_verified_false" do
      get "/linimasa/v1/janji_politiks", params: { filter_by: :user_verified_false }
      expect(json_response[:data][:janji_politiks].size).to eq(5)
    end

    it "filter by user_verified_false" do
      get "/linimasa/v1/janji_politiks", params: { filter_by: :user_verified_false, q: "selam" }
      expect(json_response[:data][:janji_politiks].size).to eq(1)
    end

    it "filter by user_verified_false" do
      get "/linimasa/v1/janji_politiks", params: { filter_by: :user_verified_false, q: "BunKeR" }
      expect(json_response[:data][:janji_politiks].size).to eq(4)
    end

    it "no filter : user_verified_all" do
      get "/linimasa/v1/janji_politiks", params: { filter_by: :user_verified_all }
      expect(json_response[:data][:janji_politiks].size).to eq(5)
    end
    it "no filter : user_verified_all" do
      JanjiPolitik.last.destroy
      get "/linimasa/v1/janji_politiks", params: { filter_by: :user_verified_all }
      expect(JanjiPolitik.all.size).to eq(4)
      expect(json_response[:data][:janji_politiks].size).to eq(4)
    end
  end

  describe "[POST] Endpoint /janji_politiks" do
    it "should returns 201 with valid params when success" do
      post "/linimasa/v1/janji_politiks",
           params:  {
             title: "Berbagi nasi bungkus bersama rakyat.",
             body:  "Tak ayal apapun dilakukan",
             image: fixture_file_upload('files/janji_image.jpg', 'image/jpg')
           },
           headers: stub_eligible_auth_headers
      expect(json_response[:data][:janji_politik][:title]).to eq("Berbagi nasi bungkus bersama rakyat.")
      expect(json_response[:data][:janji_politik][:body]).to eq("Tak ayal apapun dilakukan")
      expect(response.status).to eq(201)
    end
  end

  describe "[PUT] Endpoint /janji_politiks/picture" do
    before do
      @janji_politik = create :janji_politik, title: "Pengadaan Bunker Anti Bencana", body: "Pada 2019, di wacanakan bunker anti bencana siap di resmikan."
      JanjiPolitik.reindex
    end
    it "should returns 201 with valid params when success" do
      put "/linimasa/v1/janji_politiks/image",
          params:  {
            id:    @janji_politik.id,
            image: fixture_file_upload('files/janji_image.jpg', 'image/jpg')
          },
          headers: stub_eligible_auth_headers
      expect(json_response[:data][:janji_politik][:image]).to eq({
                                                                   "large" => {
                                                                     "url" => "#{ENV["BASE_URL"]}/uploads/janji_politik/image/#{json_response[:data][:janji_politik][:id]}/large_janji_image.jpg"
                                                                   },
                                                                   "url"   => "#{ENV["BASE_URL"]}/uploads/janji_politik/image/#{json_response[:data][:janji_politik][:id]}/janji_image.jpg" })
      expect(response.status).to eq(200)
    end
  end

  describe "pagination" do
    before do
      @crowling = create :crowling, keywords: :rizagalih, team: 1
    end
    it "paginate searchkick page 1" do
      13.times do
        FactoryBot.create :janji_politik, title: Faker::Lorem.sentences(2), body: Faker::Lorem.sentences(4)
      end
      JanjiPolitik.reindex
      # total record = 13
      get "/linimasa/v1/janji_politiks", headers: stub_auth_headers(@access_token),
          params:                                 { page: 1, per_page: 5 }
      expect(response.status).to eq(200)
      expect(json_response[:data][:janji_politiks].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 2" do
      13.times do
        FactoryBot.create :janji_politik, title: Faker::Lorem.sentences(2), body: Faker::Lorem.sentences(4)
      end
      JanjiPolitik.reindex
      # total record = 13
      get "/linimasa/v1/janji_politiks", headers: stub_auth_headers(@access_token),
          params:                                 { page: 2, per_page: 5 }
      expect(response.status).to eq(200)
      expect(json_response[:data][:janji_politiks].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 3" do
      13.times do
        FactoryBot.create :janji_politik, title: Faker::Lorem.sentences(2), body: Faker::Lorem.sentences(4)
      end
      JanjiPolitik.reindex
      # total record = 13
      get "/linimasa/v1/janji_politiks", headers: stub_auth_headers(@access_token),
          params:                                 { page: 3, per_page: 5 }
      expect(response.status).to eq(200)
      expect(json_response[:data][:janji_politiks].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 4" do
      13.times do
        FactoryBot.create :janji_politik, title: Faker::Lorem.sentences(2), body: Faker::Lorem.sentences(4)
      end
      JanjiPolitik.reindex
      # total record = 13
      get "/linimasa/v1/janji_politiks", headers: stub_auth_headers(@access_token),
          params:                                 { page: 4, per_page: 5 }
      expect(response.status).to eq(200)
      expect(json_response[:data][:janji_politiks].size).to eq(0)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end
  end

  describe "[GET] Endpoint /linimasa/v1/janji_politiks/trashes" do
    before do
      @janji_politik = create :janji_politik, title: "Pengadaan Bunker Anti Bencana", body: "Pada 2019, di wacanakan bunker anti bencana siap di resmikan."
      @janji_politik.delete
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/janji_politiks/trashes", headers: stub_admin_auth_headers
      expect(json_response[:data][:politiks].size).to eq(1)
      title = json_response[:data][:politiks].pluck(:title)
      expect(title).not_to eq(nil)
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 100, "total" => 1 } })
      expect(response.status).to eq(200)
    end
  end

  describe "detail trash politiks" do
    before do
      @janji_politik = create :janji_politik, title: "Pengadaan Bunker Anti Bencana", body: "Pada 2019, di wacanakan bunker anti bencana siap di resmikan."
      @janji_politik.delete
    end
    it "should returns 200 / success" do
      get "/linimasa/v1/janji_politiks/trash/#{@janji_politik.id}", headers: stub_admin_auth_headers
      expect(json_response[:data][:politiks][:id]).to eq(@janji_politik.id)
    end
  end

end
