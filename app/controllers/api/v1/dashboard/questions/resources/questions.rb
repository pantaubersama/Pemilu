class API::V1::Dashboard::Questions::Resources::Questions < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "question_folders" do

    desc "Add / edit questions to folders" do
      detail "Add / edit questions to folders"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :title, type: String
      requires :description, type: String
      requires :image, type: File
    end
    oauth2
    put "/questions" do
      
    end

  end

  # permitted params
  helpers do
    def quiz_params
      permitted_params(params.except(:access_token)).permit(:title, :description, :image)
    end
  end

end
