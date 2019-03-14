require 'rails_helper'

RSpec.describe "Api::V1::Hitung::Images", type: :request do
  before do
    @access_token = SecureRandom.hex
    @file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
    @hitung1 = FactoryBot.create :hitung_real_count, status: "published", user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
    @hitung2 = FactoryBot.create :hitung_real_count, status: "published", user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
  end

  describe "Upload file" do
    it "success" do
      post "/hitung/v1/images/", headers: stub_auth_headers(@access_token),
        params: {
          image_type: "suasana_tps",
          file: @file,
          hitung_real_count_id: @hitung1.id
        }
      expect(response.status).to eq(201)
    end

    it "should fail" do
      post "/hitung/v1/images/", headers: stub_auth_headers(@access_token),
        params: {
          image_type: "suasana_tps",
          file: @file,
          hitung_real_count_id: @hitung2.id
        }
      expect(response.status).to eq(404)
    end
  end

  describe "Delete file" do
    before do
      @image1 = FactoryBot.create :hitung_image, hitung_real_count_id: @hitung1.id, file: @file
      @image2 = FactoryBot.create :hitung_image, hitung_real_count_id: @hitung2.id, file: @file
    end

    it "success" do
      delete "/hitung/v1/images/#{@image1.id}", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end

    it "should fail" do
      delete "/hitung/v1/images/#{@image2.id}", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(404)
    end
  end

  describe "suasana tps" do
    it "success return 200" do
      get "/hitung/v1/images?image_type=suasana_tps", headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
    end
  end

end
