require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::Quizzes", type: :request do
  before do
    @access_token = SecureRandom.hex
  end
  
  describe "Authorized" do
    it "authorized" do
      post "/dashboard/v1/quizzes", headers: stub_admin_auth_headers(@access_token),
        params: {
          title: "Quiz 1",
          description: "Deskripsi",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
        }
      expect(response.status).to eq(201)
    end
    it "not authorized" do
      post "/dashboard/v1/quizzes", headers: stub_not_authorized_headers(@access_token),
        params: {
          title: "Quiz 1",
          description: "Deskripsi",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
        }
      expect(response.status).to eq(403)
    end
  end

  describe "create" do
    it "success" do
      post "/dashboard/v1/quizzes", headers: stub_admin_auth_headers(@access_token),
        params: {
          title: "Quiz 1",
          description: "Deskripsi",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
        }
      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
      expect(json_response[:data][:quiz][:title]).to eq("Quiz 1")
      expect(Quiz.find(json_response[:data][:quiz][:id]).status).to eq("draft")
    end
  end

  describe "update" do
    it "success" do
      quiz = FactoryBot.create :quiz, status: "draft"
      put "/dashboard/v1/quizzes/#{quiz.id}", headers: stub_admin_auth_headers(@access_token),
        params: {
          title: "Quiz 1 ubah",
          description: "Deskripsi",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
      expect(json_response[:data][:quiz][:title]).to eq("Quiz 1 ubah")
    end
  end

  describe "delete" do
    it "success" do
      quiz = FactoryBot.create :quiz, status: "draft"
      delete "/dashboard/v1/quizzes/#{quiz.id}", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
    end
  end

  describe "change status" do
    before do
      @quiz = FactoryBot.create :quiz, status: "draft"
    end

    it "draft" do
      post "/dashboard/v1/quizzes/#{@quiz.id}/draft", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
      expect(@quiz.reload.status).to eq("draft")
    end

    it "published" do
      post "/dashboard/v1/quizzes/#{@quiz.id}/publish", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
      expect(@quiz.reload.status).to eq("published")
    end

    it "archived" do
      post "/dashboard/v1/quizzes/#{@quiz.id}/archive", headers: stub_admin_auth_headers(@access_token)
      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
      expect(@quiz.reload.status).to eq("archived")
    end
  end
end