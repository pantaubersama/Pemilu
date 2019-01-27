class API::V1::Lapor::ViolationReports::Entities::ViolationReport::Party < Grape::Entity
  expose :id
  expose :name
  expose :address
  expose :telephone_number
end
