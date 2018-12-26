require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::Crowlings", type: :request do
  describe "[POST] Endpoint /linimasa/crowling/" do
    it "should returns 201 with valid params when success" do
      post "/dashboard/v1/linimasa/crowling/username",
           params:  { keywords: "rizagalih", team: 1 },
           headers: auth_headers
      expect(json_response[:data][:crowling][:keywords]).to eq("rizagalih")
      expect(json_response[:data][:crowling][:team]).to eq(1)
      expect(json_response[:data][:crowling][:team_text]).to eq("Jokowi - Makruf")
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
      get "/dashboard/v1/linimasa/crowling", headers: auth_headers
      expect(json_response[:data][:crowlings].size).to eq(2)
      keywords = json_response[:data][:crowlings].pluck(:keywords)
      expect(keywords.include?("rizagalih")).to eq(true)
      expect(keywords.include?("alamybs")).to eq(true)
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 100, "total" => 2 } })
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/dashboard/v1/linimasa/crowling", params: { page: 1, per_page: 1 }, headers: auth_headers
      expect(json_response[:data][:crowlings].size).to eq(1)
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 1, "total" => 1 } })
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
      get "/dashboard/v1/linimasa/crowling/trashes", headers: auth_headers
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
      delete "/dashboard/v1/linimasa/crowling", params: { id: @rizagalih.id }, headers: auth_headers
      expect(json_response[:data][:message]).to eq("Crowling id #{@rizagalih.id} berhasil dihapus")
      expect(response.status).to eq(200)
    end
  end
end