require "rails_helper"

RSpec.describe "API::V1::Hitung::UnduhData", type: :request do
  describe "[POST] /hitung/v1/unduh_data/request" do
    it "success" do
      post "/hitung/v1/unduh_data/request", params: {
        name: "kakaroto",
        email: "email@example.com",
        phone: "0822249xxxx",
        necessity: "kepentingan keluarga",
        organization: "ABC"
      }
      expect(response.status).to eq(201)
    end
  end
end
