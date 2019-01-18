module API::V1::PendidikanPolitik::Quizzes::Resources
  class Quizzes < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "quizzes" do

      desc "List quiz" do
        detail "List quiz. <br> Display all quizzes if no token. <br> Display no_participating quizzes if token provided."
        headers OPTIONAL_AUTHORIZATION_HEADERS
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        use :searchkick_search, default_m: "word_start", default_o: "and"
      end
      optional_oauth2
      get "/" do
        q = params.q.nil? || params.q.empty? ? "*" : params.q
        operator = params.o.nil? || params.o.empty? ? "and" : params.o
        match_word = params.m.nil? || params.m.empty? ? :word_start : params.m.to_sym

        query = current_user.present? ? QuizParticipation.where(user_id: current_user.id) : nil
        build_conditions = {}
        build_conditions = if current_user.present?
          {id: {not: query.map(&:quiz_id) }}
        end

        resources = Quiz.search(q, operator: operator, match: match_word, misspellings: false,
          load: false, page: (params.page || 1), per_page: (params.per_page || Pagy::VARS[:items]), where: build_conditions)
        
        present :quizzes, resources, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, 
          current_user: current_user,
          index_version: true,
          quiz_participations: (query.map{|q| [q.quiz_id, q.status]} if query) 
        present_metas_searchkick resources
      end

      desc "List quiz (in progress / finished)" do
        detail "List quiz (in progress / finished)"
        headers AUTHORIZATION_HEADERS
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        use :searchkick_search, default_m: "word_start", default_o: "and"
        use :filter, filter_by: ["in_progress", "finished"], default_filter_by: "in_progress"
      end
      oauth2
      get "/participated" do
        q = params.q.nil? || params.q.empty? ? "*" : params.q
        operator = params.o.nil? || params.o.empty? ? "and" : params.o
        match_word = params.m.nil? || params.m.empty? ? :word_start : params.m.to_sym

        query = current_user.present? ? QuizParticipation.where(user_id: current_user.id) : nil
        build_conditions = {}
        build_conditions = if current_user.present? && params.filter_by.present?
          if params.filter_by.to_sym != :all
            {id: query.where(status: params.filter_by.to_s).map(&:quiz_id)}
          end
        end

        resources = Quiz.search(q, operator: operator, match: match_word, misspellings: false,
          load: false, page: (params.page || 1), per_page: (params.per_page || Pagy::VARS[:items]), where: build_conditions)
        
        present :quizzes, resources, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, 
          current_user: current_user,
          index_version: true,
          quiz_participations: (query.map{|q| [q.quiz_id, q.status]} if query) 
          present_metas_searchkick resources
      end

      desc "Detail quiz" do
        detail "Detail quiz"
        headers OPTIONAL_AUTHORIZATION_HEADERS
      end
      optional_oauth2
      get "/:id" do
        quiz = ::Quiz.published.find params.id
        present :quiz, quiz, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, quiz_detail: true, current_user: current_user
      end

    end


  end
end