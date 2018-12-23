class Api::V1::PendidikanPolitik::Questions::Resources::Questions < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "questions" do
    desc "List question" do
      detail "List question"
    end
    paginate per_page: 10, max_per_page: 100
    get "/" do
      questions = Question.all
      resources = paginate(questions)
      present :questions, resources, with: Api::V1::PendidikanPolitik::Questions::Entities::Question
      present_metas resources
    end

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
    
    desc "Delete a question" do
      detail "Delete a question"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :id
    end
    oauth2
    delete "/" do
      q = Question.find_by id: params[:id], user_id: current_user.id
      
      error!("ID not found : #{params.id}", 404) unless q

      del = q.destroy!

      present status: q.paranoia_destroyed?
    end
    
  end

  # permitted params
  helpers do
    def question_params
      permitted_params(params.except(:access_token)).permit(:body, :user_id)
    end
  end
end
