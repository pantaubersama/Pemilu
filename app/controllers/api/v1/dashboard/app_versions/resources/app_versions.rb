class API::V1::Dashboard::AppVersions::Resources::AppVersions < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "app_versions" do

    desc "List" do
      detail "List"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :app_type, type: String, values: ["android", "ios"]
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    oauth2
    get "/" do
      q = AppVersion.where(app_type: params.app_type).order(created_at: :desc)
      resources = paginate(q)
      error! "Not found" unless q.present?
      present :app_version, q, with: API::V1::Dashboard::AppVersions::Entities::AppVersion
      present_metas resources
    end

    desc "Create" do
      detail "Create"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :name, type: String
      requires :version_code, type: Integer
      requires :force_update, type: Boolean
      requires :app_type, type: String, values: ["android", "ios"]
    end
    oauth2
    post "/" do
      q = AppVersion.new app_params
      status = q.save!
      present :status, status
      present :app_version, q, with: API::V1::Dashboard::AppVersions::Entities::AppVersion
    end
    
    desc "Update" do
      detail "Update"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :name, type: String
      optional :version_code, type: Integer
      optional :force_update, type: Boolean
      optional :app_type, type: String, values: ["android", "ios"]
    end
    oauth2
    put "/:id" do
      q = AppVersion.find params.id
      error! "Not found" unless q.present?
      status = q.update_attributes!(app_params)
      present :status, status
      present :app_version, q, with: API::V1::Dashboard::AppVersions::Entities::AppVersion
    end

    desc "Delete" do
      detail "Delete"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/:id" do
      q = AppVersion.find params.id
      error! "Not found" unless q.present?
      status = q.destroy!
      present :status, status.destroyed?
      present :app_version, q, with: API::V1::Dashboard::AppVersions::Entities::AppVersion
    end

    desc "Detail" do
      detail "Detail"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/:id" do
      q = AppVersion.find params.id
      error! "Not found" unless q.present?
      present :app_version, q, with: API::V1::Dashboard::AppVersions::Entities::AppVersion
    end

  end

  helpers do
    def app_params
      permitted_params(params.except(:access_token)).permit(:name, :force_update, :app_type, :version_code)
    end
  end

end
