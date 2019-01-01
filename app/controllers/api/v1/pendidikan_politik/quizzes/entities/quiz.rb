include ::API::V1::Helpers

module API::V1::PendidikanPolitik::Quizzes::Entities
  class Quiz < Grape::Entity
    expose :title
    expose :description
    expose :image
    expose :quiz_questions_count
    expose :created_at, format_with: :friendly_date

    expose :participation_status do |obj, opt|
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

  end
end