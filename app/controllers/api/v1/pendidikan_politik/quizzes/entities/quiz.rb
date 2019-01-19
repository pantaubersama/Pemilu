include ::API::V1::Helpers

module API::V1::PendidikanPolitik::Quizzes::Entities
  class Quiz < API::V1::ApplicationEntity
    expose :id
    expose :title
    expose :description
    expose :image
    expose :quiz_questions_count
    # expose :created_at, if: lambda { |c,o| o[:index_version].present? }
    # expose :created_at, format_with: :friendly_date, unless: lambda { |c,o| o[:index_version].present? }

    expose :participation_status, if: lambda { |o,p| p[:quiz_detail].nil? } do |obj, opt|
      if opt[:quiz_participations].nil? || opt[:quiz_participations].empty?
        :not_participating
      else
        if opt[:quiz_participations].select{|x, y| x == obj.id }.first.present?
          opt[:quiz_participations].select{|x, y| x == obj.id }.first.last
        else
          :not_participating
        end
      end
    end

    expose :participation_status, if: lambda { |o,p| p[:quiz_detail].present? } do |obj, opt|
      if opt[:current_user].nil?
        :not_participating
      elsif obj.quiz_participations.where(user_id: opt[:current_user].id).first.nil?
        :not_participating
      else
        obj.quiz_participations.where(user_id: opt[:current_user].id).first.status
      end
    end

  end
end
