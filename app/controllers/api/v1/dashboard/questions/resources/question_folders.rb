class API::V1::Dashboard::Questions::Resources::QuestionFolders < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "question_folders" do

    desc "Trash" do
      detail "Trash folder"
      headers AUTHORIZATION_HEADERS
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get "/trash" do
      q = QuestionFolder.only_deleted
      resources = paginate(q)
      present :question_folders, resources, with: API::V1::Dashboard::Questions::Entities::QuestionFolder
      present_metas resources
    end

    desc "List" do
      detail "List folder"
      headers AUTHORIZATION_HEADERS
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get "/" do
      q = QuestionFolder.all
      resources = paginate(q)
      present :question_folders, resources, with: API::V1::Dashboard::Questions::Entities::QuestionFolder
      present_metas resources
    end

    desc "Create folder" do
      detail "Create folder"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :name, type: String
    end
    oauth2
    post "/" do
      q = QuestionFolder.new name: params.name
      error! "Not found" unless q.present?
      status = q.save!
      present :status, status
      present :question_folder, q, with: API::V1::Dashboard::Questions::Entities::QuestionFolder
    end

    desc "Update folder" do
      detail "Update folder"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :name, type: String
    end
    oauth2
    put "/:id" do
      q = QuestionFolder.find params.id
      error! "Not found" unless q.present?
      status = q.update_attributes({name: params.name})
      present :status, status
      present :question_folder, q, with: API::V1::Dashboard::Questions::Entities::QuestionFolder
    end

    desc "Delete folder" do
      detail "Delete folder"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/:id" do
      q = QuestionFolder.find params.id
      error! "Not found" unless q.present?
      status = q.destroy!
      present :status, status.paranoia_destroyed?
      present :question_folder, q, with: API::V1::Dashboard::Questions::Entities::QuestionFolder
    end

    desc "Detail folder" do
      detail "Detail folder"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/:id" do
      q = QuestionFolder.find params.id
      error! "Not found" unless q.present?
      present :question_folder, q, with: API::V1::Dashboard::Questions::Entities::QuestionFolder
    end

  end

end
