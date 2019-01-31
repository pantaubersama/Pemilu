class API::V1::Lapor::ViolationReports::Entities::ViolationReport::Report < Grape::Entity
  expose :id
  expose :reporter, using: API::V1::Users::Entities::UserSimple
  expose :dimension_id
  expose :title
  expose :description
  expose :created_at
  expose :updated_at
  expose :detail, using: API::V1::Lapor::ViolationReports::Entities::ViolationReport::Detail, if: { type: :full }
end
