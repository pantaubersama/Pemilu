class API::V1::Dashboard::Questions::Resources::Questions < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "question_folders" do

    desc "Get list of questions" do
      detail "Get list of questions"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/:id/questions" do
      f = QuestionFolder.find params.id

      present :question_folder, f, with: API::V1::Dashboard::Questions::Entities::QuestionFolder
      present :questions, f.questions, with: API::V1::PendidikanPolitik::Questions::Entities::Question
    end

    desc "Add / edit questions to folders" do
      detail "Add / edit questions to folders"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :question_ids, type: String, desc: "Question ID separated by comma"
    end
    oauth2
    put "/:id/questions" do
      f = QuestionFolder.find params.id
      f.remove_existing_questions
      f.add_questions(params.question_ids.split(",").map(&:strip))
      present :question_folder, f, with: API::V1::Dashboard::Questions::Entities::QuestionFolder
      present :questions, f.questions, with: API::V1::PendidikanPolitik::Questions::Entities::Question
    end

  end

  # permitted params
  helpers do
    def quiz_params
      permitted_params(params.except(:access_token)).permit(:title, :description, :image)
    end
  end

end
