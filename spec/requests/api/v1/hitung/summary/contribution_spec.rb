require "rails_helper"

RSpec.describe "API::V1::Hitung::Contribution", type: :request do
  describe "[GET] /hitung/v1/summary/contribution" do
    it "success" do
      get "/hitung/v1/summary/contribution"
      expect(response.status).to eq(200)
    end
  end
end
