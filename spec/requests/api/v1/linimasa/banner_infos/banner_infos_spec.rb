require 'rails_helper'

RSpec.describe "Api::V1::Linimasa::BannerInfos", type: :request do
  describe "[GET] Endpoint /banner_infos" do
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos"
      expect(json_response[:data][:banner_infos].size).to eq(10)
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
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "lapor"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("lapor")
      expect(json_response[:data][:banner_info][:title]).to eq("Lapor")
      expect(json_response[:data][:banner_info][:body]).to eq("Lapor")
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "debat"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("debat")
      expect(json_response[:data][:banner_info][:title]).to eq("Debat")
      expect(json_response[:data][:banner_info][:body]).to eq("Debat")
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "tantangan"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("tantangan")
      expect(json_response[:data][:banner_info][:title]).to eq("Tantangan")
      expect(json_response[:data][:banner_info][:body]).to eq("Tantangan")
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "perhitungan"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("perhitungan")
      expect(json_response[:data][:banner_info][:title]).to eq("Perhitungan")
      expect(json_response[:data][:banner_info][:body]).to eq("Perhitungan")
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "my_input"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("my_input")
      expect(json_response[:data][:banner_info][:title]).to eq("My Input")
      expect(json_response[:data][:banner_info][:body]).to eq("My Input")
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success" do
      get "/linimasa/v1/banner_infos/show", params: {page_name: "rekapitulasi"}
      expect(json_response[:data][:banner_info][:page_name]).to eq("rekapitulasi")
      expect(json_response[:data][:banner_info][:title]).to eq("rekapitulasi")
      expect(json_response[:data][:banner_info][:body]).to eq("rekapitulasi")
      expect(response.status).to eq(200)
    end


  end
end
