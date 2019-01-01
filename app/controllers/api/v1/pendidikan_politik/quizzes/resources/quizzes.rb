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
        use :filter, filter_by: %i(all not_participating in_progress finished)
      end
      optional_oauth2
      get "/" do
        default_conditions = {}
        build_conditions = params.filter_by.present? ? quiz_filter(params.filter_by) : default_conditions

        q = ::Quiz.published.order("quizzes.created_at desc")
        if current_user.present? && params.filter_by.present?
          if params.filter_by.to_sym == :not_participating
            participated_quizzes = QuizParticipation.where(user_id: current_user.id).map(&:quiz_id)
            q = q.where.not(id: participated_quizzes)
          elsif params.filter_by.to_sym != :all
            q = q.includes(:quiz_participations).where(build_conditions)
              .where(quiz_participations: {user_id: current_user.id})
          end
        end
        resources = paginate(q)
        quiz_participations = ::QuizParticipation.where(quiz: resources.map(&:id), user_id: current_user.id).map{|q| [q.quiz_id, q.status]} if current_user.present?

        
        present :quizzes, resources, with: API::V1::PendidikanPolitik::Quizzes::Entities::Quiz, current_user: current_user, quiz_participations: quiz_participations 
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