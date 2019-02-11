module API::V1::Dashboard::QuestionsActions::Entities
  class Question < Grape::Entity
    expose :id
    expose :body
    expose :status
    expose :question_folder_id
    expose :question_folder, using: API::V1::Dashboard::Questions::Entities::QuestionFolder
    expose :user, using: API::V1::PendidikanPolitik::Questions::Entities::User
  end
end