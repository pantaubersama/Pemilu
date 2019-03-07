require 'rails_helper'

RSpec.describe "Api::V1::Hitung::Calculation", type: :request do
  before do
    @access_token = SecureRandom.hex
    @hitung = FactoryBot.create :hitung_real_count, status: "published", user_id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737"
    @hitung2 = FactoryBot.create :hitung_real_count, status: "published", user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8"
  end

  describe "Authorization" do
    it "authorized" do
      candidates = [
        {
          id: 1,
          total_vote: 100
        },
        {
          id: 2,
          total_vote: 200
        }
      ]
      response, json_response = build_calculation @hitung, "presiden", 10, candidates
      expect(response.status).to eq(200)
    end

    it "not authorized" do
      candidates = [
        {
          id: 1,
          total_vote: 100
        },
        {
          id: 2,
          total_vote: 200
        }
      ]
      response, json_response = build_calculation @hitung2, "presiden", 10, candidates
      expect(response.status).to eq(404)
    end
  end

  def build_calculation hitung, calculation_type, invalid_vote, candidates, parties = nil
    p = {
      hitung_real_count_id: hitung.id,
      calculation_type: calculation_type,
      invalid_vote: invalid_vote,
      candidates: candidates,
    }
    p[:parties] =  parties if parties.present?
    put "/hitung/v1/calculations/", headers: stub_auth_headers(@access_token),
      params: p
    [response, json_response]
  end
end
