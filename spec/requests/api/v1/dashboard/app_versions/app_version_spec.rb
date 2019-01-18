require 'rails_helper'

RSpec.describe "Api::V1::AppVersion", type: :request do

  before do
    @access_token = SecureRandom.hex
    stub_find_user
    5.times do
      FactoryBot.create :app_version, app_type: "android"
      FactoryBot.create :app_version, app_type: "ios"
    end
  end

  describe "App Version" do
    it "list" do
      get "/dashboard/v1/app_versions", headers: stub_admin_auth_headers(@access_token),
        params: {
          app_type: "android"
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:app_version].size).to eq(5)
    end

    it "display" do
      get "/dashboard/v1/app_versions/#{AppVersion.last.id}", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:app_version][:id]).to eq(AppVersion.last.id)
    end

    it "create" do
      post "/dashboard/v1/app_versions", headers: stub_admin_auth_headers(@access_token), 
        params: { 
          name: Faker::Lorem.sentence(2),
          app_type: "android",
          force_update: true 
        }
      expect(response.status).to eq(201)
      expect(json_response[:data][:app_version][:force_update]).to eq(true)
    end

    it "update" do
      put "/dashboard/v1/app_versions/#{AppVersion.last.id}", headers: stub_admin_auth_headers(@access_token), 
        params: { 
          name: "2.0.0",
          app_type: "android",
          force_update: false 
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:app_version][:force_update]).to eq(false)
      expect(json_response[:data][:app_version][:version]).to eq("2.0.0")
    end

    it "delete" do
      delete "/dashboard/v1/app_versions/#{AppVersion.last.id}", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(AppVersion.all.size).to  eq(9)
    end

    it "Last version" do
      get "/dashboard/v1/app_versions/last_version",
        params: {
          app_type: "android"
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:app_version][:force_update]).to eq(false)

      get "/dashboard/v1/app_versions/last_version",
        params: {
          app_type: "ios"
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:app_version][:force_update]).to eq(false)

      AppVersion.where(app_type: "ios").last.update_attribute(:force_update, true)
      get "/dashboard/v1/app_versions/last_version",
        params: {
          app_type: "ios"
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:app_version][:force_update]).to eq(true)
    end

  end
  
end