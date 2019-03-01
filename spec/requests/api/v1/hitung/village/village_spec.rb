require "rails_helper"

RSpec.describe "API::V1::Hitung::Villages", type: :request do
  describe "[GET] /hitung/v1/villages" do
    it "should return 200" do
      populate_region
      get "/hitung/v1/villages", params: {
        district_code: 927110
      }
      expect(response.status).to eq(200)
    end
  end
end
