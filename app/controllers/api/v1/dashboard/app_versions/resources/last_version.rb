class API::V1::Dashboard::AppVersions::Resources::LastVersion < API::V1::ApplicationResource

  resource "app_versions" do

    desc "Last Version" do
      detail "Last Version"
    end
    params do
      requires :app_type, type: String, values: ["android", "ios"]
    end
    get "/last_version" do
      q = AppVersion.where(app_type: params.app_type).order(created_at: :asc).last
      error! "Not found" unless q.present?
      present :app_version, q, with: API::V1::Dashboard::AppVersions::Entities::AppVersion
    end

  end

end
