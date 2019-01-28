class API::V1::Dashboard::Quizzes::Resources::Quizzes < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  before do
    authorize_admin!
  end

  resource "quizzes" do

    desc "All" do
      detail "All quiz"
      headers AUTHORIZATION_HEADERS
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    params do
      optional :q, type: String
    end
    oauth2
    get "/" do
      q = Quiz.all.order("created_at desc")
      q = q.where("lower(title) like ?", params.q.downcase + "%") if params.q.present?
      resources = paginate(q)
      present :quizzes, resources, with: API::V1::Dashboard::Quizzes::Entities::Quiz
      present_metas resources
    end

    desc "Trash" do
      detail "Trash quiz"
      headers AUTHORIZATION_HEADERS
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get "/trash" do
      q = Quiz.only_deleted.order("created_at desc")
      resources = paginate(q)
      present :quizzes, resources, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz
      present_metas resources
    end

    desc "Create quiz" do
      detail "Create quiz"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :title, type: String
      requires :description, type: String
      requires :image, type: File
    end
    oauth2
    post "/" do
      params[:image] = prepare_file(params[:image]) if params[:image].present?
      q = Quiz.new quiz_params
      q.status = "draft"
      status = q.save!
      present :status, status
      present :quiz, q, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz
    end

    desc "Update quiz" do
      detail "Update quiz"
      headers AUTHORIZATION_HEADERS
    end
    params do
      optional :title, type: String
      optional :description, type: String
      optional :image, type: File
    end
    oauth2
    put "/:id" do
      params[:image] = prepare_file(params[:image]) if params[:image].present?
      q = Quiz.find params.id
      status = q.update_attributes(quiz_params)
      present :status, status
      present :quiz, q, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz
    end

    desc "Delete quiz" do
      detail "Delete quiz"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/:id" do
      q = Quiz.find params.id
      status = q.destroy!
      present :status, status.paranoia_destroyed?
      present :quiz, q, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz
    end

    desc "Publish quiz" do
      detail "Publish quiz"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    post "/:id/publish" do
      q = Quiz.find params.id
      status = q.published!
      present :status, q.published?
      present :quiz, q, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz
    end

    desc "Un-Publish quiz" do
      detail "Un-Publish quiz"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    post "/:id/draft" do
      q = Quiz.find params.id
      status = q.draft!
      present :status, q.draft?
      present :quiz, q, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz
    end

    desc "Archive quiz" do
      detail "Archive quiz"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    post "/:id/archive" do
      q = Quiz.find params.id
      status = q.archived!
      present :status, q.archived?
      present :quiz, q, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz
    end

    desc "Detail quiz" do
      detail "Detail quiz"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/:id" do
      quiz = ::Quiz.find params.id
      present :quiz, quiz, with: API::V1::Dashboard::Quizzes::Entities::Quiz
    end

  end

  # permitted params
  helpers do
    def quiz_params
      permitted_params(params.except(:access_token)).permit(:title, :description, :image)
    end
  end

end
