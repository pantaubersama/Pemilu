require 'rails_helper'

RSpec.describe "Api::V1::PendidikanPolitik::Resources::Question", type: :request do
  let(:user) { create :user }

  before do
    @access_token = SecureRandom.hex
    5.times do
      FactoryBot.create :question
    end
    stub_user_model
    Question.reindex
  end

  describe "pagination" do
    it "paginate searchkick page 1" do
      8.times do
        FactoryBot.create :question
      end
      Question.reindex
      # total record = 13
      get "/pendidikan_politik/v1/questions", headers: stub_auth_headers(@access_token),
        params: {page: 1, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 2" do
      8.times do
        FactoryBot.create :question
      end
      Question.reindex
      # total record = 13
      get "/pendidikan_politik/v1/questions", headers: stub_auth_headers(@access_token),
        params: {page: 2, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 3" do
      8.times do
        FactoryBot.create :question
      end
      Question.reindex
      # total record = 13
      get "/pendidikan_politik/v1/questions", headers: stub_auth_headers(@access_token),
        params: {page: 3, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 4" do
      8.times do
        FactoryBot.create :question
      end
      Question.reindex
      # total record = 13
      get "/pendidikan_politik/v1/questions", headers: stub_auth_headers(@access_token),
        params: {page: 4, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(0)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end
  end

  describe "[POST] Endpoint /" do
    it "should returns 201 with valid params when success" do
      post "/pendidikan_politik/v1/questions", headers: stub_auth_headers(@access_token),
           params:                                      { body: "Apakah harga premium akan disubsidi pemerintah?" }
      expect(response.status).to eq(201)
      expect(json_response[:data][:status]).to eq(true)
    end
  end

  describe "[GET] Endpoint /:id" do
    it "should return 200 with valid ID" do
      q = Question.last
      get "/pendidikan_politik/v1/questions/#{q.id}"
      expect(response.status).to eq(200)
      expect(json_response[:data][:question][:id]).to eq(q.id)
    end
  end

  describe "[DELETE] Endpoint /" do
    it "should returns 200 when success" do
      q = Question.last
      delete "/pendidikan_politik/v1/questions", params: { id: q.id }, headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)

      Question.reindex
      get "/pendidikan_politik/v1/questions", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:questions].size).to eq(4)
    end

    it "404 question is not owned by current_user" do
      q = Question.create user_id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8", body: Faker::Lorem.sentence(3)
      delete "/pendidikan_politik/v1/questions", params: { id: q.id }, headers: stub_auth_headers(@access_token)
      expect(response.status).to eq(404)
    end
  end

  describe "[GET] Endpoint /" do
    it "List questions" do
      # Question.reindex
      get "/pendidikan_politik/v1/questions"
      expect(json_response[:data][:questions].size).to eq(5)
      expect(response.status).to eq(200)
    end
  end

  describe "[GET] Endpoint sorting /" do
    it "sorting by created_at desc (default)" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?order_by=&direction="
      expect(json_response[:data][:questions][0][:created_at]).to be >= json_response[:data][:questions][1][:created_at]
    end

    it "sorting by created_at desc" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?order_by=created_at&direction=desc"
      expect(json_response[:data][:questions][0][:created_at]).to be >= json_response[:data][:questions][1][:created_at]
    end

    it "sorting by created_at asc" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?order_by=created_at&direction=asc"
      expect(json_response[:data][:questions][0][:created_at]).to be <= json_response[:data][:questions][1][:created_at]
    end

    it "sorting by cached_votes_up desc" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?order_by=cached_votes_up&direction=desc"
      expect(json_response[:data][:questions][0][:like_count]).to be >= json_response[:data][:questions][1][:like_count]
    end

    it "sorting by cached_votes_up asc" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?order_by=cached_votes_up&direction=asc"
      expect(json_response[:data][:questions][0][:like_count]).to be <= json_response[:data][:questions][1][:like_count]
    end

    it "sorting by trending (hot score desc)" do
      get "/pendidikan_politik/v1/questions?order_by=cached_votes_up&direction=asc"
      obj1 = json_response[:data][:questions][0]["id"]
      obj2 = json_response[:data][:questions][1]["id"]
      question1 = Question.find obj1
      question2 = Question.find obj2

      like question2
      Question.reindex

      get "/pendidikan_politik/v1/questions?order_by=hot_score&direction=desc"
      expect(json_response[:data][:questions][0][:temperature].round).to eq(11)
      expect(json_response[:data][:questions][0][:id]).to eq(obj2)
      expect(json_response[:data][:questions][1][:id]).to eq(obj1)

      unlike question2
      Question.reindex

      get "/pendidikan_politik/v1/questions?order_by=hot_score&direction=desc"
      expect(json_response[:data][:questions][0][:temperature].round).to eq(2)
      expect(json_response[:data][:questions][0][:id]).to eq(obj2)
      expect(json_response[:data][:questions][1][:id]).to eq(obj1)

      like question1
      Question.reindex

      get "/pendidikan_politik/v1/questions?order_by=hot_score&direction=desc"
      expect(json_response[:data][:questions][0][:temperature].round).to eq(11)
      expect(json_response[:data][:questions][0][:id]).to eq(obj1)
      expect(json_response[:data][:questions][1][:id]).to eq(obj2)
    end

    def like(question)
      params = { id: question.id, class_name: 'Question' }
      post '/pendidikan_politik/v1/votes', headers: stub_auth_headers(user: user), params: params
    end

    def unlike(question)
      params = { id: question.id, class_name: 'Question' }
      delete '/pendidikan_politik/v1/votes', headers: stub_auth_headers(user: user), params: params
    end
  end

  describe "[GET] Endpoint /" do
    it "success" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?filter_by="
      expect(response.status).to eq(200)
    end

    it "filter by user_verified_true" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?filter_by=user_verified_true"
      expect(json_response[:data][:questions].size).to eq(0)
    end

    it "filter by user_verified_false" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?filter_by=user_verified_false"
      expect(json_response[:data][:questions].size).to eq(5)
    end

    it "no filter : user_verified_all" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?filter_by=user_verified_all"
      expect(json_response[:data][:questions].size).to eq(5)
    end
  end

  describe "[GET] Endpoint /" do
    it "mix parameters : pagination, filter, order [1]" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?filter_by=user_verified_false&order_by=cached_votes_up&direction=asc&page=1&per_page=3"
      expect(json_response[:data][:questions].size).to eq(3)
      expect(json_response[:data][:questions][0][:like_count]).to be <= json_response[:data][:questions][1][:like_count]
    end

    it "mix parameters : pagination, filter, order [2]" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?filter_by=user_verified_false&order_by=cached_votes_up&direction=asc&page=2&per_page=3"
      expect(json_response[:data][:questions].size).to eq(2)
      expect(json_response[:data][:questions][0][:like_count]).to be <= json_response[:data][:questions][1][:like_count]
    end

    it "mix parameters : pagination, filter, order [3]" do
      Question.reindex
      get "/pendidikan_politik/v1/questions?filter_by=user_verified_false&order_by=cached_votes_up&direction=asc&page=3&per_page=3"
      expect(json_response[:data][:questions].size).to eq(0)
    end
  end

  describe "[GET] Endpoint /" do
    before do
      FactoryBot.create :question, body: "Lorem gembel"
      FactoryBot.create :question, body: "Lorem gembel wedus"
      Question.reindex
    end

    it "success" do
      get "/pendidikan_politik/v1/questions?q=&o=&m="
      expect(response.status).to eq(200)
    end

    it "search" do
      get "/pendidikan_politik/v1/questions?q=gembel"
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to be >= 2
    end

    it "search not found" do
      get "/pendidikan_politik/v1/questions?q=telek%20gembel"
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(0)
    end

    it "search using or" do
      get "/pendidikan_politik/v1/questions?q=telek%20gembel&o=or"
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to be >= 2
    end

    it "search using match word_start" do
      get "/pendidikan_politik/v1/questions?q=gem"
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to be >= 2
    end

    it "search using match word_start not found" do
      get "/pendidikan_politik/v1/questions?q=mbel"
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(0)
    end

    it "search using match word_end" do
      get "/pendidikan_politik/v1/questions?q=mbel&m=word_end"
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(2)
    end

    it "search using match word not found" do
      get "/pendidikan_politik/v1/questions?q=gem&m=word"
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(0)
    end

    it "search using match word" do
      get "/pendidikan_politik/v1/questions?q=gembel&m=word"
      expect(response.status).to eq(200)
      expect(json_response[:data][:questions].size).to eq(2)
    end

  end

  describe "My question" do
    it "Have 7 question" do
      FactoryBot.create :question
      FactoryBot.create :question, question_folder_id: FactoryBot.create(:question_folder).id
      get "/pendidikan_politik/v1/me/questions", headers: stub_auth_headers(@access_token)
      expect(json_response[:data][:questions].size).to eq(7)
    end
  end

end
