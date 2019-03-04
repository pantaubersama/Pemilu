module API::V1::Hitung::Candidates::Resources
  class Candidates < API::V1::ApplicationResource
    helpers API::V1::Helpers

    resource "candidates" do
      desc "get candidates by dapil" do
        detail "get candidates by dapil"
      end
      params do
        requires :dapil_id, type: Integer, desc: "Dapil ID"
        requires :tingkat, type: String, values: %w[dpr provinsi kabupaten dpd], desc: "Tingkat Pemilihan"
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]

      get "/" do
        candidates = Candidate.joins(:dapil)
          .where(electoral_district_id: params.dapil_id)
          .where("dapils.tingkat = ? ", Dapil.tingkats[params.tingkat])
          .order(political_party_id: :asc)
          .order(serial_number: :asc)

        resources = paginate(candidates)
        present :candidates, resources, with: API::V1::Hitung::Candidates::Entities::Candidate
        present_metas resources
      end
    end
  end
end
