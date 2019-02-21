require "rails_helper"

RSpec.describe "Api::V1::Dashboard::BannerInfos", type: :request do

  before do
    @access_token = SecureRandom.hex
  end

  describe "[PUT]  /dashboard/v1/banner_infos" do
    it "success update banner with page_name pilpres" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Pilpres",
        body: "Pilpres",
        page_name: "pilpres",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Pilpres")
      expect(json_response['data']['banner_info']['body']).to eq("Pilpres")
      expect(json_response['data']['banner_info']['page_name']).to eq("pilpres")
    end
    it "success update banner with page_name janji politik" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Janji Politik",
        body: "Janji Politik",
        page_name: "janji politik",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Janji Politik")
      expect(json_response['data']['banner_info']['body']).to eq("Janji Politik")
      expect(json_response['data']['banner_info']['page_name']).to eq("janji politik")
    end
    it "success update banner with page_name tanya" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Tanya",
        body: "Tanya",
        page_name: "tanya",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Tanya")
      expect(json_response['data']['banner_info']['body']).to eq("Tanya")
      expect(json_response['data']['banner_info']['page_name']).to eq("tanya")
    end
    it "success update banner with page_name kuis" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Kuis",
        body: "Kuis",
        page_name: "kuis",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Kuis")
      expect(json_response['data']['banner_info']['body']).to eq("Kuis")
      expect(json_response['data']['banner_info']['page_name']).to eq("kuis")
    end
    it "success update banner with page_name lapor" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Lapor",
        body: "Lapor",
        page_name: "lapor",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Lapor")
      expect(json_response['data']['banner_info']['body']).to eq("Lapor")
      expect(json_response['data']['banner_info']['page_name']).to eq("lapor")
    end
    it "success update banner with page_name debat" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Debat",
        body: "Debat",
        page_name: "debat",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Debat")
      expect(json_response['data']['banner_info']['body']).to eq("Debat")
      expect(json_response['data']['banner_info']['page_name']).to eq("debat")
    end
    it "success update banner with page_name tantangan" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Tantangan",
        body: "Tantangan",
        page_name: "tantangan",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Tantangan")
      expect(json_response['data']['banner_info']['body']).to eq("Tantangan")
      expect(json_response['data']['banner_info']['page_name']).to eq("tantangan")
    end
    it "success update banner with page_name perhitungan" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Perhitungan",
        body: "Perhitungan",
        page_name: "perhitungan",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Perhitungan")
      expect(json_response['data']['banner_info']['body']).to eq("Perhitungan")
      expect(json_response['data']['banner_info']['page_name']).to eq("perhitungan")
    end
    it "success update banner with page_name my_input" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "My Input",
        body: "My Input",
        page_name: "my_input",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("My Input")
      expect(json_response['data']['banner_info']['body']).to eq("My Input")
      expect(json_response['data']['banner_info']['page_name']).to eq("my_input")
    end
    it "success update banner with page_name rekapitulasi" do
      put "/dashboard/v1/banner_infos", headers:stub_admin_auth_headers(@access_token),
      params: {
        title: "Rekapitulasi",
        body: "Rekapitulasi",
        page_name: "rekapitulasi",
        header_image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
      }
      expect(response.status).to eq(200)
      expect(json_response['data']['banner_info']['title']).to eq("Rekapitulasi")
      expect(json_response['data']['banner_info']['body']).to eq("Rekapitulasi")
      expect(json_response['data']['banner_info']['page_name']).to eq("rekapitulasi")
    end
  end

end
