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
      requires :body, type: String, desc: "Questions"
    end
    oauth2
    put "/:id" do
      question = Question.find params.id
      error! "Not found" unless question.present?
      status = question.update_attributes({name: params.name})
      present :status, status
      present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question			
    end
	end

end
