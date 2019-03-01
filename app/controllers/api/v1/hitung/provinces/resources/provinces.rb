class API::V1::Hitung::Provinces::Resources::Provinces < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "regions" do
    resource "provinces" do
      desc "get list of provinces" do
        detail "get list of provinces"
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      get "/" do
        provs = Province.all
        resources = paginate(provs)
        present :provinces, resources, with: API::V1::Hitung::Provinces::Entities::Province
        present_metas resources
      end
    end
  end
end
