require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::Feeds", type: :request do
  describe "pagination" do
    before do
      @crowling = create :crowling, keywords: :rizagalih, team: 1
    end
    it "paginate searchkick page 1" do
      13.times do
        FactoryBot.create :feed, team: 1, crowling_id: @crowling.id, source_id: Faker::Number.number(10), source_text: Faker::Lorem.sentence(2), account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed"
      end
      Feed.reindex
      # total record = 13
      get "/linimasa/v1/feeds/pilpres", headers: stub_auth_headers(@access_token),
          params:                                { page: 1, per_page: 5 }
      expect(response.status).to eq(200)
      expect(json_response[:data][:feeds].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 2" do
      13.times do
        FactoryBot.create :feed, team: 1, crowling_id: @crowling.id, source_id: Faker::Number.number(10), source_text: Faker::Lorem.sentence(2), account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed"
      end
      Feed.reindex
      # total record = 13
      get "/linimasa/v1/feeds/pilpres", headers: stub_auth_headers(@access_token),
          params:                                { page: 2, per_page: 5 }
      expect(response.status).to eq(200)
      expect(json_response[:data][:feeds].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 3" do
      13.times do
        FactoryBot.create :feed, team: 1, crowling_id: @crowling.id, source_id: Faker::Number.number(10), source_text: Faker::Lorem.sentence(2), account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed"
      end
      Feed.reindex
      # total record = 13
      get "/linimasa/v1/feeds/pilpres", headers: stub_auth_headers(@access_token),
          params:                                { page: 3, per_page: 5 }
      expect(response.status).to eq(200)
      expect(json_response[:data][:feeds].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 4" do
      13.times do
        FactoryBot.create :feed, team: 1, crowling_id: @crowling.id, source_id: Faker::Number.number(10), source_text: Faker::Lorem.sentence(2), account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed"
      end
      Feed.reindex
      # total record = 13
      get "/linimasa/v1/feeds/pilpres", headers: stub_auth_headers(@access_token),
          params:                                { page: 4, per_page: 5 }
      expect(response.status).to eq(200)
      expect(json_response[:data][:feeds].size).to eq(0)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end
  end

  describe "[GET] Endpoint /feeds/pilpres" do
    before do
      crowling_1 = create :crowling, keywords: :rizagalih, team: 1
      create :feed, crowling: crowling_1, source_id: 969376813649510400, source_text: "can't wait any longer. Please kam kam kam sini", account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed", team: 1
      create :feed, crowling: crowling_1, source_id: 969876460256161792, source_text: "can't wait...!!! https://t.co/CuRJ9tz5y8", account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed", team: 1
      create :feed, crowling: crowling_1, source_id: 971408683409158146, source_text: "dari fajar yg terlewatkan, bkn berarti tidak bisa", account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed", team: 1

      crowling_2 = create :crowling, keywords: :alamybs, team: 2
      create :feed, crowling: crowling_1, source_id: 969876460256161712, source_text: "Woooo", account_id: 99252433, account_name: "Alam ybs", account_username: "alamybs", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed", team: 2
      create :feed, crowling: crowling_2, source_id: 971408683409154546, source_text: "Iki disik lek", account_id: 99252433, account_name: "Alam ybs", account_username: "alamybs", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed", team: 2
      Feed.reindex
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/feeds/pilpres", headers: stub_auth_headers
      expect(json_response[:data][:feeds].size).to eq(5)
      expect(json_response[:data][:feeds].last[:team]).to eq({
                                                               "avatar" => "https://s3-ap-southeast-1.amazonaws.com/pantau-bersama/assets/teams/avatar_team_1.jpg",
                                                               "id"     => 1,
                                                               "title"  => "Tim Jokowi - Ma'ruf"
                                                             })
      expect(response.status).to eq(200)
    end

    it "filter by team_all" do
      get "/linimasa/v1/feeds/pilpres", params: { filter_by: :team_all }
      expect(json_response[:data][:feeds].size).to eq(5)
    end

    it "filter by user_verified_false" do
      get "/linimasa/v1/feeds/pilpres", params: { filter_by: :team_id_1 }
      expect(json_response[:data][:feeds].size).to eq(3)
    end

    it "filter by user_verified_false with search q" do
      get "/linimasa/v1/feeds/pilpres", params: { filter_by: :team_id_1, q: "can" }
      expect(json_response[:data][:feeds].size).to eq(2)
    end

    it "filter by team_id_2" do
      get "/linimasa/v1/feeds/pilpres", params: { filter_by: :team_id_2 }
      expect(json_response[:data][:feeds].size).to eq(2)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/feeds/pilpres/#{Feed.first.id}", headers: stub_auth_headers
      expect(json_response[:data][:feed][:team]).to eq({
                                                         "avatar" => "https://s3-ap-southeast-1.amazonaws.com/pantau-bersama/assets/teams/avatar_team_1.jpg",
                                                         "id"     => 1,
                                                         "title"  => "Tim Jokowi - Ma'ruf"
                                                       })
      expect(response.status).to eq(200)
    end
  end

  describe "[GET] Endpoint /linimasa/v1/feeds/trashes" do
    before do
      @crowling = create :crowling, keywords: :rizagalih, team: 1
      @feed     = FactoryBot.create :feed, team: 1, crowling_id: @crowling.id, source_id: Faker::Number.number(10), source_text: Faker::Lorem.sentence(2), account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed"
      @feed.delete
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/feeds/trashes", headers: stub_admin_auth_headers
      expect(json_response[:data][:feeds].size).to eq(1)
      team = json_response[:data][:feeds].pluck(:team)
      expect(team).not_to eq(nil)
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 100, "total" => 1 } })
      expect(response.status).to eq(200)
    end
  end

  describe "[GET] /linimasa/v1/feeds/trash/:id" do
    before do
      @crowling = create :crowling, keywords: :rizagalih, team: 1
      @feed     = FactoryBot.create :feed, team: 1, crowling_id: @crowling.id, source_id: Faker::Number.number(10), source_text: Faker::Lorem.sentence(2), account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed"
      @feed.delete
    end
    it "should returns 200 / success" do
      get "/linimasa/v1/feeds/trash/#{@feed.id}", headers: stub_admin_auth_headers
      expect(json_response[:data][:feed][:id]).to eq(@feed.id)
    end
  end

  describe "[DELETE] Endpoint /linimasa/v1/feeds" do
    before do
      @crowling = create :crowling, keywords: :rizagalih, team: 1
      @feed     = FactoryBot.create :feed, team: 1, crowling_id: @crowling.id, source_id: Faker::Number.number(10), source_text: Faker::Lorem.sentence(2), account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed"
    end
    it "should returns 200 with valid params when success" do
      delete "/linimasa/v1/feeds", params: { id: @feed.id }, headers: stub_admin_auth_headers
      expect(json_response[:data][:message]).to eq("Feed id #{@feed.id} berhasil dihapus")
      expect(response.status).to eq(200)
    end
  end
  describe "[POST] Endpoint /linimasa/v1/feeds" do
    before do
      @crowling_1 = create :crowling, keywords: :rizagalih, team: 1
      @crowling_2 = create :crowling, keywords: :namakukingkong, team: 2
      @params     = { feeds: [{
                                team_id:     1,
                                crowling_id: @crowling_1.id,
                                id:          Faker::Number.number(10),
                                full_text:   Faker::Lorem.sentence(2),
                                media:       [{
                                                id:              123,
                                                media_url_https: "https://pbs.twimg.com/media/DxbnBp2U0AA8DDu.jpg",
                                              },
                                              {
                                                id:              124,
                                                media_url_https: "https://pbs.twimg.com/media/DxbnBp2U0AA8DDu.jpg",
                                              }],
                                user:        {
                                  id:                99252433,
                                  name:              "Icung Icha",
                                  screen_name:       "rizagalih",
                                  profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg"
                                },
                                created_at:  Time.zone.now
                              },
                              {
                                team_id:     2,
                                crowling_id: @crowling_2.id,
                                id:          Faker::Number.number(10),
                                full_text:   Faker::Lorem.sentence(3),
                                user:        {
                                  id:                8282891928,
                                  name:              "Alam Ybs",
                                  screen_name:       "namakukingkong",
                                  profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg"
                                },
                                created_at:  Time.zone.now
                              }] }
    end
    it "should returns 200 with valid params when success" do
      post "/linimasa/v1/feeds", params: @params, headers: stub_admin_auth_headers
      expect(Feed.all.size).to eq(2)
      expect(Feed.find_by(crowling_id: @crowling_1.id).source_media).to eq(["https://pbs.twimg.com/media/DxbnBp2U0AA8DDu.jpg", "https://pbs.twimg.com/media/DxbnBp2U0AA8DDu.jpg"])
      expect(json_response[:data]).to eq({ "message" => "Success Created feeds" })
    end
  end

end
