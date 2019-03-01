class API::V1::Hitung::Regencies::Resources::Regencies < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "regions" do
    resource "regencies" do
      desc "get list of regencies" do
        detail "get list of regencies"
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        requires :province_code, type: Integer, desc: "Province id/code"
      end
      get "/" do
        regencies = Regency.where(province_id: params.province_code)
        resources = paginate(regencies)
        present :regencies, resources, with: API::V1::Hitung::Regencies::Entities::Regency
        present_metas resources
      end
    end
  end
end
