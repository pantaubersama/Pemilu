class API::V1::Lapor::ViolationReports::Entities::ViolationReport::Detail < Grape::Entity
  expose :location
  expose :occurrence_time
  expose :reportee, using: API::V1::Lapor::ViolationReports::Entities::ViolationReport::Party
  expose :witnesses, using: API::V1::Lapor::ViolationReports::Entities::ViolationReport::Party
  expose :evidences, using: API::V1::Lapor::ViolationReports::Entities::ViolationReport::Evidence
end
