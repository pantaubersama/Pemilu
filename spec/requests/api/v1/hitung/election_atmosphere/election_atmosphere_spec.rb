require "rails_helper"

RSpec.describe "API::V1::Hitung::ElectionAtmosphere", type: :request do
  describe "[GET] /hitung/v1/election_atmosphere" do
      it "success return 200" do
        get "/hitung/v1/election_atmosphere"
        expect(response.status).to eq(200)
      end
    end
end
