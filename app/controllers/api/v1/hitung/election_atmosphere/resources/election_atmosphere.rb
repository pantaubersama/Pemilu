module API::V1::Hitung::ElectionAtmosphere::Resources
  class ElectionAtmosphere < API::V1::ApplicationResource
    helpers API::V1::Helpers

    resource "election_atmosphere" do
      desc "get list election atmosphere/keseruan suasana pemilihan" do
        detail "get list election atmosphere/keseruan suasana pemilihan"
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      get "/" do
        suasana_tps = ::Hitung::Image.where(image_type: "suasana_tps")
        resources = paginate(suasana_tps)
        present :election_atmospheres, resources, with: API::V1::Hitung::ElectionAtmosphere::Entities::ElectionAtmosphere
        present_metas resources
      end
    end
  end
end
