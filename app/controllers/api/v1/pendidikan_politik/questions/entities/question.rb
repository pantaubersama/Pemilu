module API::V1::PendidikanPolitik::Questions::Entities
  class Question < Grape::Entity
    expose :id
    expose :body, documentation: {type: String, desc: "Question body"}
  end
end
