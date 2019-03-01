require "rails_helper"

RSpec.describe "API::V1::Hitung::Districts", type: :request do
  describe "[GET] /hitung/v1/regions/districts" do
    it "should return 200" do
      province =  FactoryBot.create(:province)
      regency = FactoryBot.create(:regency, province_id: province.id)
      FactoryBot.create(:district, regency_code: regency.code)
      FactoryBot.create(:district, regency_code: regency.code)

      get "/hitung/v1/regions/districts", params: {
        regency_code: regency.code
      }
      expect(response.status).to eq(200)
      expect(json_response[:data][:districts].size).to eq(2)
    end
  end
end
