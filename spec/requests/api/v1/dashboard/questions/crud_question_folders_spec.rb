require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::QuestionsFolder", type: :request do
  before do
    @access_token = SecureRandom.hex
    stub_user_model
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


  describe "pagination" do
    before do
      12.times do
        FactoryBot.create :question_folder
      end
    end

    it "paginate default" do
      # total 13 pages
      get "/dashboard/v1/question_folders", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to  eq(200)
      expect(json_response[:data][:question_folders].size).to  eq(13)
      expect(json_response[:data][:meta][:pages][:total]).to eq(1)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(100)
    end

    it "paginate page 1" do
      # total 13 pages
      get "/dashboard/v1/question_folders", headers: stub_admin_auth_headers(@access_token),
        params: {
          page: 1,
          per_page: 5
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:question_folders].size).to  eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate page 2" do
      # total 13 pages
      get "/dashboard/v1/question_folders", headers: stub_admin_auth_headers(@access_token),
        params: {
          page: 2,
          per_page: 5
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:question_folders].size).to  eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate page 3" do
      # total 13 pages
      get "/dashboard/v1/question_folders", headers: stub_admin_auth_headers(@access_token),
        params: {
          page: 3,
          per_page: 5
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:question_folders].size).to  eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate page 4" do
      # total 13 pages
      get "/dashboard/v1/question_folders", headers: stub_admin_auth_headers(@access_token),
        params: {
          page: 4,
          per_page: 5
        }
      expect(response.status).to  eq(406)
      # expect(json_response[:data][:question_folders].size).to  eq(0)
      # expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      # expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      # expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end
  end


end
