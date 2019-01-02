require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::Feeds", type: :request do
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
                                                                 "avatar" => "https://s3-ap-southeast-1.amazonaws.com/pantau-test/assets/teams/avatar_team_1.png",
                                                                 "id"     => 1,
                                                                 "title"  => "Jokowi - Makruf"
                                                             })
      expect(response.status).to eq(200)
    end
    it "filter by team_all" do
      get "/linimasa/v1/feeds/pilpres", params: {filter_by: :team_all}
      expect(json_response[:data][:feeds].size).to eq(5)
    end

    it "filter by user_verified_false" do
      get "/linimasa/v1/feeds/pilpres", params: {filter_by: :team_id_1}
      expect(json_response[:data][:feeds].size).to eq(3)
    end

    it "filter by team_id_2" do
      get "/linimasa/v1/feeds/pilpres", params: {filter_by: :team_id_2}
      expect(json_response[:data][:feeds].size).to eq(2)
    end
  end
end