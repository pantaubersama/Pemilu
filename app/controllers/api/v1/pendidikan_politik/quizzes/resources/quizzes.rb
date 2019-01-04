module API::V1::PendidikanPolitik::Quizzes::Resources
  class Quizzes < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "quizzes" do

      desc "List quiz" do
        detail "List quiz"
        headers OPTIONAL_AUTHORIZATION_HEADERS
      end
      paginate per_page: 25, max_per_page: 500
      params do
        use :searchkick_search, default_m: :word_start, default_o: "and"
        use :filter, filter_by: %i(all not_participating in_progress finished)
      end
      optional_oauth2
      get "/" do
        q = params.q.nil? || params.q.empty? ? "*" : params.q
        operator = params.o.nil? || params.o.empty? ? "and" : params.o
        match_word = params.m.nil? || params.m.empty? ? :word_start : params.m.to_sym

        query = current_user.present? ? QuizParticipation.where(user_id: current_user.id) : nil
        build_conditions = {}
        build_conditions = if current_user.present? && params.filter_by.present?
          if params.filter_by.to_sym == :not_participating
            {id: {not: query.map(&:quiz_id) }}
          elsif params.filter_by.to_sym != :all
            {id: query.where(status: params.filter_by.to_s).map(&:quiz_id)}
          end
        end

        resources = Quiz.search(q, operator: operator, match: match_word, misspellings: false,
          load: false, page: params.page, per_page: params.per_page, where: build_conditions).results
        
        present :quizzes, resources, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, 
          current_user: current_user,
          index_version: true,
          quiz_participations: (query.map{|q| [q.quiz_id, q.status]} if query) 
        present_metas resources
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