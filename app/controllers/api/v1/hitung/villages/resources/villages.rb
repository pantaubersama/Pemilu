class API::V1::Hitung::Villages::Resources::Villages < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "regions" do
    resource "villages" do
      desc "get list of villages" do
        detail "get list of villages"
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        requires :district_code, type: Integer, desc: "District Code"
      end
      get "/" do
        villages = Village.where(district_code: params.district_code)
        resources = paginate(villages)
        present :villages, resources, with: API::V1::Hitung::Villages::Entities::Village
        present_metas resources
      end
    end
  end
end
