class API::V1::Dashboard::Home::Resources::Statistics < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "home" do

    desc "Statistics" do
      detail "Statistics"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/statistics" do
      present :quizzes, Quiz.search("*").total_count
      present :questions, Question.search("*").total_count
      present :question_upvotes, ActsAsVotable::Vote.where(votable_type: "Question", vote_flag: true).count
      present :janji_politiks, JanjiPolitik.search("*").total_count
      present :feeds, Feed.search("*").total_count
      present :report, ViolationReport::Report.all.count
    end

  end

end
