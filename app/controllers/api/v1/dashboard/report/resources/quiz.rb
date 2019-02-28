class API::V1::Dashboard::Report::Resources::Quiz < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "report" do

    desc "percentage of candidates per questions" do
      detail "percentage of candidates per questions"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    params do
      optional :quiz_id
    end
    get "/per_questions" do
      present ::Report::Quiz.per_questions(params.quiz_id)
    end

  end

end
