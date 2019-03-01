require "rails_helper"

RSpec.describe "API::V1::Hitung::Provinces", type: :request do
  describe "[GET] /hitung/v1/provinces" do
    it "should return 200" do
      get "/hitung/v1/provinces"
      expect(response.status).to eq(200)
    end
  end
end
