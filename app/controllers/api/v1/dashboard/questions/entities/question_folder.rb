module API::V1::Dashboard::Questions::Entities
  class QuestionFolder < Grape::Entity
    expose :id
    expose :name
    expose :questions_count
  end
end