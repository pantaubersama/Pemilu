module API::V1::Dashboard::Quizzes::Entities
  class Quiz < API::V1::PendidikanPolitik::Quizzes::Entities::Quiz
    unexpose :participation_status
    expose :status
  end
end