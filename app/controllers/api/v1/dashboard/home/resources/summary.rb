class API::V1::Dashboard::Home::Resources::Summary < API::V1::ApplicationResource
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

    desc "User registrations chart" do
      detail "User registrations chart"
      headers AUTHORIZATION_HEADERS
    end
    params do
      optional :month_from, values: (1..12).to_a, type: Integer
      optional :year_from, values: (2018..2024).to_a, type: Integer
      optional :month_to, values: (1..12).to_a, type: Integer
      optional :year_to, values: (2018..2024).to_a, type: Integer
    end
    oauth2
    get "/questions" do
      res = Question.all
      if params.month_from.present? && params.year_from.present?
        res = res.where("created_at >= ?", Date.new(params.year_from, params.month_from, 1).to_s) 
      end
      if params.month_to.present? && params.year_to.present?
        res = res.where("created_at <= ?", Date.civil(params.year_to, params.month_to, -1).to_s)
      end
      data = res.group_by_month(:created_at, format: "%b %Y").count
      present data
    end

    desc "Violation report chart" do
      detail "Violation report chart"
      headers AUTHORIZATION_HEADERS
    end
    params do
      optional :month_from, values: (1..12).to_a, type: Integer
      optional :year_from, values: (2018..2024).to_a, type: Integer
      optional :month_to, values: (1..12).to_a, type: Integer
      optional :year_to, values: (2018..2024).to_a, type: Integer
    end
    oauth2
    get "/reports" do
      res = ViolationReport::Report.all
      if params.month_from.present? && params.year_from.present?
        res = res.where("created_at >= ?", Date.new(params.year_from, params.month_from, 1).to_s) 
      end
      if params.month_to.present? && params.year_to.present?
        res = res.where("created_at <= ?", Date.civil(params.year_to, params.month_to, -1).to_s)
      end
      data = res.group_by_month(:created_at, format: "%b %Y").count
      present data
    end

  end

end
