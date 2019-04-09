require "rails_helper"

RSpec.describe "API::V1::Hitung::Regencies", type: :request do

  describe "[GET] /hitung/v1/regencies" do
    it "should return 200" do
      populate_region
      get "/hitung/v1/regencies", params: {
        province_code: 92
      }
      expect(response.status).to eq(200)
      expect(json_response[:data][:regencies].size).to eq(1)
    end
  end
end
