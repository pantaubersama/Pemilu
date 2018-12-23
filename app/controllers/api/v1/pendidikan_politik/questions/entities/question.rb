class Api::V1::PendidikanPolitik::Questions::Entities::Question < Grape::Entity
  expose :id
  expose :body, documentation: {type: String, desc: "Question body"}
end
