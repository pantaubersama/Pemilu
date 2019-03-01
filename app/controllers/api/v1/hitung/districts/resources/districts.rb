class API::V1::Hitung::Districts::Resources::Districts < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "regions" do
    resource "districts" do
      desc "get list of districts" do
        detail "get list of districts"
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        requires :regency_code, type: Integer, desc: "Regency id/code"
      end
      get "/" do
        districts = District.where(regency_code: params.regency_code)
        resources = paginate(districts)
        present :districts, resources, with: API::V1::Hitung::Districts::Entities::District
        present_metas resources
      end
    end
  end
end
