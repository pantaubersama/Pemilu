class API::V1::Dashboard::Quizzes::Resources::Questions < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  before do
    authorize_admin!
  end

  resource "questions" do

    desc "List question (all => active & archived)" do
      detail "List question (all => active & archived)"
      headers AUTHORIZATION_HEADERS
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    params do
      use :searchkick_search, default_m: :word_start, default_o: "and"
      use :order, order_by: [:created_at, :cached_votes_up], default_order_by: :created_at, default_order: :desc
      use :filter, filter_by: %i(user_verified_all user_verified_true user_verified_false)
    end
    oauth2
    get "/" do
      q = params.q.nil? || params.q.empty? ? "*" : params.q
      operator = params.o.nil? || params.o.empty? ? "and" : params.o
      match_word = params.m.nil? || params.m.empty? ? :word_start : params.m.to_sym

      default_order = {created_at: {order: :desc, unmapped_type: "long"}}
      build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => { order: params.direction.to_sym, unmapped_type: "long"  } } : default_order

      default_conditions = {}
      build_conditions = params.filter_by.present? ? default_conditions.merge(question_filter(params.filter_by)) : default_conditions

      resources = Question.search(q, operator: operator, match: match_word, misspellings: false,
        load: false, page: (params.page || 1), per_page: (params.per_page || Pagy::VARS[:items]), order: build_order, where: build_conditions)
      liked_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: current_user.id, vote_flag: true, vote_scope: nil).map(&:votable_id) if current_user.present?
      reported_resources = ActsAsVotable::Vote.where(votable_type: "Question", votable_id: resources.map(&:id), voter_id: current_user.id, vote_flag: false, vote_scope: "report").map(&:votable_id) if current_user.present?
      present :questions, resources, with: API::V1::PendidikanPolitik::Questions::Entities::Question, index_version: true, liked_resources: liked_resources, reported_resources: reported_resources
      present_metas_searchkick resources
    end

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

  resource "quizzes" do
    desc "Quiz question" do
      detail "Quiz question"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/:id/questions" do
      quiz = ::Quiz.find params[:id]

      error! "Not found", 404 if quiz.nil?
      
      present :questions, quiz.quiz_questions, with: API::V1::Dashboard::Quizzes::Entities::Question
    end
  end

  # permitted params
  helpers do
    def questions_params
      permitted_params(params.except(:access_token)).permit(:content, :team_1_answer, :team_2_answer)
    end
  end

end
