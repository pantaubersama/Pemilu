module API::V1::Dashboard::AppVersions::Entities
  class AppVersion < Grape::Entity
    expose :id
    expose :name, as: :version
    expose :app_type
    expose :force_update
  end
end