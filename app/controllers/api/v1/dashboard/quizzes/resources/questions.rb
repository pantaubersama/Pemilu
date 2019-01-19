class API::V1::Dashboard::Quizzes::Resources::Questions < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "questions" do
    desc "Trash" do
      detail "Trash question"
      headers AUTHORIZATION_HEADERS
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get "/trash" do
      q = Question.only_deleted
      resources = paginate(q)
      present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question
      present_metas resources
    end

    desc "Add quiz question" do
      detail "Add quiz question"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :quiz_id, type: String
      requires :content, type: String
      requires :team_1_answer, type: String
      requires :team_2_answer, type: String
    end
    oauth2
    post "/" do
      quiz = Quiz.find params.quiz_id
      error! "Not found" unless quiz.present?

      q1 = QuizQuestion.create! quiz: quiz, content: params.content
      a1 = QuizAnswer.create! quiz_question: q1, content: params.team_1_answer, team: 1
      a2 = QuizAnswer.create! quiz_question: q1, content: params.team_2_answer, team: 2

      present :quiz, quiz, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, quiz_detail: true
      present :questions, quiz.quiz_questions.order(Arel.sql("RANDOM()")), with: API::V1::PendidikanPolitik::Quizzes::Entities::Question
    end

    desc "Edit quiz question" do
      detail "Edit quiz question"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :quiz_id, type: String
      optional :content, type: String
      optional :team_1_answer, type: String
      optional :team_2_answer, type: String
    end
    oauth2
    put "/:id" do
      quiz = Quiz.find params.quiz_id
      error! "Not found" unless quiz.present?

      q1 = QuizQuestion.find_by id: params.id, quiz_id: params.quiz_id
      error! "Not found" unless q1.present?

      a1 = q1.quiz_answers.find_by(team: 1)
      a2 = q1.quiz_answers.find_by(team: 2)
      
      q1.update_attributes({content: params.content}) if params.content.present?
      a1.update_attributes({content: params.team_1_answer}) if params.team_1_answer.present?
      a2.update_attributes({content: params.team_2_answer}) if params.team_2_answer.present?

      present :quiz, quiz, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, quiz_detail: true
      present :questions, quiz.quiz_questions.order(Arel.sql("RANDOM()")), with: API::V1::PendidikanPolitik::Quizzes::Entities::Question
    end

    desc "Detail quiz question" do
      detail "Detail quiz question"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :quiz_id, type: String
    end
    oauth2
    get "/:id" do
      q1 = QuizQuestion.find_by id: params.id, quiz_id: params.quiz_id

      error! "Not found" unless q1.present?

      present :quiz, q1.quiz, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, quiz_detail: true
      present :questions, q1, with: API::V1::PendidikanPolitik::Quizzes::Entities::Question
    end

    desc "Delete quiz question" do
      detail "Delete quiz question"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :quiz_id, type: String
    end
    oauth2
    delete "/:id" do
      q1 = QuizQuestion.find_by id: params.id, quiz_id: params.quiz_id

      error! "Not found" unless q1.present?

      status = q1.destroy!

      quiz = Quiz.find params.quiz_id

      present :status, status
      present :quiz, quiz, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, quiz_detail: true
      present :questions, quiz.quiz_questions.order(Arel.sql("RANDOM()")), with: API::V1::PendidikanPolitik::Quizzes::Entities::Question
    end

  end

  # permitted params
  helpers do
    def questions_params
      permitted_params(params.except(:access_token)).permit(:content, :team_1_answer, :team_2_answer)
    end
  end

end
