class Api::V1::PendidikanPolitik::Questions::Resources::Questions < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "questions" do
    desc "Create a question" do
      detail "Create a question"
      headers AUTHORIZATION_HEADERS
      params Api::V1::PendidikanPolitik::Questions::Entities::Question.documentation
    end
    oauth2
    post "/" do
      params[:user_id] = current_user.id
      q = Question.new question_params
      status = q.save!
      present :status, status
      present :question, q, with: Api::V1::PendidikanPolitik::Questions::Entities::Question
    end

    desc "Show a question" do
      detail "Show a question"
    end
    params do 
      requires :id
    end
    get "/:id" do
      q = Question.find params[:id]
      present :question, q, with: Api::V1::PendidikanPolitik::Questions::Entities::Question
    end
    
  end

  # permitted params
  helpers do
    def question_params
      permitted_params(params.except(:access_token)).permit(:body, :user_id)
    end
  end
end
