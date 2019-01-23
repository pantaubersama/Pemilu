require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::Crowlings", type: :request do
  describe "[POST] Endpoint /linimasa/crowling/" do
    it "should returns 201 with valid params when success" do
      post "/dashboard/v1/linimasa/crowling/username",
           params:  { keywords: "rizagalih", team: 1 },
           headers: stub_admin_auth_headers
      expect(json_response[:data][:crowling][:keywords]).to eq("rizagalih")
      expect(json_response[:data][:crowling][:team]).to eq({
                                                               "avatar" => "https://s3-ap-southeast-1.amazonaws.com/pantau-bersama/assets/teams/avatar_team_1.jpg",
                                                               "id"     => 1,
                                                               "title"  => "Tim Jokowi - Ma'ruf"
                                                           })
      expect(json_response[:data][:crowling][:created_at].present?).to eq(true)
      expect(json_response[:data][:crowling][:id].present?).to eq(true)
      expect(response.status).to eq(201)
    end
  end
  describe "[GET] Endpoint /linimasa/crowling/" do
    before do
      create :crowling, keywords: :rizagalih, team: 1
      create :crowling, keywords: :alamybs, team: 2
    end
    it "should returns 200 with valid params when success" do
      get "/dashboard/v1/linimasa/crowling", headers: stub_admin_auth_headers
      expect(json_response[:data][:crowlings].size).to eq(2)
      keywords = json_response[:data][:crowlings].pluck(:keywords)
      expect(keywords.include?("rizagalih")).to eq(true)
      expect(keywords.include?("alamybs")).to eq(true)
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 100, "total" => 1 } })
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/dashboard/v1/linimasa/crowling", params: { page: 1, per_page: 1 }, headers: stub_admin_auth_headers
      expect(json_response[:data][:crowlings].size).to eq(1)
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 1, "total" => 2 } })
      expect(response.status).to eq(200)
    end
  end
  describe "[GET] Endpoint /linimasa/crowling/trashes" do
    before do
      @crowling = create :crowling, keywords: :namakukingkong, team: 1
      create :crowling, keywords: :rizagalih, team: 1
      create :crowling, keywords: :alamybs, team: 2
      @crowling.destroy
    end
    it "should returns 200 with valid params when success" do
      get "/dashboard/v1/linimasa/crowling/trashes", headers: stub_admin_auth_headers
      # byebug
      expect(json_response[:data][:crowlings].size).to eq(1)
      keywords = json_response[:data][:crowlings].pluck(:keywords)
      expect(keywords.include?("namakukingkong")).to eq(true)
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 100, "total" => 1 } })
      expect(response.status).to eq(200)
    end
  end
  describe "[DELETE] Endpoint /linimasa/crowling" do
    before do
      @rizagalih = create :crowling, keywords: :rizagalih, team: 1
      create :crowling, keywords: :alamybs, team: 2
    end
    it "should returns 200 with valid params when success" do
      delete "/dashboard/v1/linimasa/crowling", params: { id: @rizagalih.id }, headers: stub_admin_auth_headers
      expect(json_response[:data][:message]).to eq("Crowling id #{@rizagalih.id} berhasil dihapus")
      expect(response.status).to eq(200)
    end
  end

  describe "detail crowling" do
    before do
      @crowling_1 = create :crowling, keywords: :rizagalih, team: 1
      create :feed, crowling: @crowling_1, source_id: 969376813649510400, source_text: "can't wait any longer. Please kam kam kam sini", account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed", team: 1
      create :feed, crowling: @crowling_1, source_id: 969876460256161792, source_text: "can't wait...!!! https://t.co/CuRJ9tz5y8", account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed", team: 1
      create :feed, crowling: @crowling_1, source_id: 971408683409158146, source_text: "dari fajar yg terlewatkan, bkn berarti tidak bisa", account_id: 99252433, account_name: "Icung Icha", account_username: "rizagalih", account_profile_image_url: "http://pbs.twimg.com/profile_images/1028985612458582016/vTOB00bG_normal.jpg", type: "TwTimelineFeed", team: 1
    end
    it "should returns 200 / success" do
      get "/dashboard/v1/linimasa/crowling/#{@crowling_1.id}", headers: stub_admin_auth_headers
      expect(response.status).to eq(200)
    end
  end
end
