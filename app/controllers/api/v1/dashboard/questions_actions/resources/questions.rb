class API::V1::Dashboard::QuestionsActions::Resources::Questions < API::V1::ApplicationResource
	helpers API::V1::Helpers

	before do
		authorize_admin!
	end

	resource "question_actions" do
		desc "Edit" do
      detail "edit questions"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :id, type: String, desc: "Question ID"
      optional :body, type: String, desc: "Questions"
      optional :status, type: String, desc: "Status"
      optional :question_folder_id, type: String, desc: "Question Folder ID"
    end
    oauth2
    put "/:id" do
      question = Question.find_by id: params[:id]
      error! "Not found" unless question.present?
      status = question.update_attributes(questions_params)
      present :status, status
      present :questions, question, with: API::V1::Dashboard::QuestionsActions::Entities::Question
    end

    desc "Delete" do
      detail "Delete a question"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :id
    end
    oauth2
    delete "/" do
      q = Question.not_in_folder.find_by id: params[:id]
      error!("ID not found : #{params.id}", 404) unless q
      del = q.destroy!
      present :question, q, with: API::V1::PendidikanPolitik::Questions::Entities::Question
      present :status, q.paranoia_destroyed?
    end

    desc "Trash" do
      detail "Trash question"
      headers AUTHORIZATION_HEADERS
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get "/trash" do
      q = Question.not_in_folder.deleted
      resources = paginate(q)
      present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question
      present_metas resources
    end

    desc "Show a question" do
      detail "Show a question"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :id
    end
    oauth2
    get "/:id" do
      q = Question.find params[:id]
      present :question, q, with: API::V1::Dashboard::QuestionsActions::Entities::Question
    end

    desc "Show Trash" do
      detail "Show Detail Trash question"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :id
    end
    oauth2
    get "/trash/:id" do
      q = Question.not_in_folder.deleted.find params[:id]
      present :questions, q, with: API::V1::PendidikanPolitik::Questions::Entities::Question
    end
    
  end

  # permitted params
  helpers do
    def questions_params
      permitted_params(params.except(:access_token)).permit(:body, :status, :question_folder_id)
    end
  end

end
