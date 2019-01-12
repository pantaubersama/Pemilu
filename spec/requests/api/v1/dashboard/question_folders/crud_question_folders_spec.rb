require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::QuestionsFolder", type: :request do
  before do
    @access_token = SecureRandom.hex
    stub_find_user
    @q = FactoryBot.create :question_folder
  end
  
  describe "Authorized" do
    it "authorized" do
      get "/dashboard/v1/question_folders", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to  eq(200)
    end
    it "not authorized" do
      get "/dashboard/v1/question_folders", headers: stub_not_authorized_headers(@access_token)
      expect(response.status).to  eq(403)
    end
  end

  describe "list" do
    it "success" do
      get "/dashboard/v1/question_folders", headers: stub_admin_auth_headers(@access_token)
      expect(json_response[:data][:question_folders].size).to  eq(1)
    end
  end

  describe "trash" do
    it "success" do
      q = FactoryBot.create :question_folder
      q.destroy!
      q = FactoryBot.create :question_folder
      q.destroy!
      get "/dashboard/v1/question_folders/trash", headers: stub_admin_auth_headers(@access_token)
      expect(json_response[:data][:question_folders].size).to  eq(2)
    end
  end

  describe "create" do
    it "success" do
      post "/dashboard/v1/question_folders", headers: stub_admin_auth_headers(@access_token),
        params: {
          name: "Hello"
        }
      expect(response.status).to eq(201)
      expect(json_response[:data][:question_folder][:name]).to eq("Hello")
    end
  end

  describe "show" do
    it "success" do
      get "/dashboard/v1/question_folders/#{@q.id}", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:question_folder][:name]).to eq(@q.name)
    end
  end

  describe "update" do
    it "success" do
      put "/dashboard/v1/question_folders/#{@q.id}", headers: stub_admin_auth_headers(@access_token),
        params: {
          name: "Hello 2"
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:question_folder][:name]).to eq("Hello 2")
    end
  end

  describe "delete" do
    it "success" do
      delete "/dashboard/v1/question_folders/#{@q.id}", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(@q.reload.paranoia_destroyed?).to eq(true)
    end
  end


end