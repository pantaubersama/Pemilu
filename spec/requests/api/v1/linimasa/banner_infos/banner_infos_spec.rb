require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::BannerInfos", type: :request do
  describe "[GET] Endpoint /banner_infos" do
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos"
      expect(json_response[:data][:banner_infos].size).to eq(4)
      expect(response.status).to eq(200)
    end
  end
  describe "[GET] Endpoint /banner_infos/show" do
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "pilpres"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("pilpres")
      expect(json_response[:data][:banner_info][:title]).to eq("Judul banner pilpres")
      expect(json_response[:data][:banner_info][:body]).to eq("Body banner pilpres")
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "janji politik"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("janji politik")
      expect(json_response[:data][:banner_info][:title]).to eq("Judul banner 'janji politik'")
      expect(json_response[:data][:banner_info][:body]).to eq("Body banner 'janji politik'")
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "tanya"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("tanya")
      expect(json_response[:data][:banner_info][:title]).to eq("Judul banner tanya")
      expect(json_response[:data][:banner_info][:body]).to eq("Body banner tanya")
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "kuis"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("kuis")
      expect(json_response[:data][:banner_info][:title]).to eq("Judul banner kuis")
      expect(json_response[:data][:banner_info][:body]).to eq("Body banner kuis")
      expect(response.status).to eq(200)
    end
  end
end
