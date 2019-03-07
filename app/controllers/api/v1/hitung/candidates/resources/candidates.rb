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
      get "/" do
        query_candidates = Candidate.joins(:dapil)
          .where(electoral_district_id: params.dapil_id)
          .where("dapils.tingkat = ? ", Dapil.tingkats[params.tingkat])
          .order(serial_number: :asc)

        if params.tingkat == "dpd"
          candidates = query_candidates
          candidates_group = candidates.group_by { |candidate| candidate.dapil }.map { |dapil, candidate|
            {
              id: dapil.id,
              nama: dapil.nama,
              actor_type: "Dapil",
              tingkat: dapil.tingkat,
              candidates: candidate.map { |c|
                {
                  id: c.id,
                  name: c.name,
                  gender: c.gender,
                  serial_number: c.serial_number,
                  actor_type: "Candidate",
                  dapil: {
                    id: c.dapil.id,
                    nama: c.dapil.nama,
                    tingkat: c.dapil.tingkat,
                  }
                }
              }
            }
          }
        else
          candidates = query_candidates
            .order(political_party_id: :asc)
            .joins(:political_party)
            .select("candidates.name as name, candidates.id as id, candidates.gender as gender, candidates.electoral_district_id as electoral_district_id, candidates.serial_number as serial_number,  political_parties.id as political_party_id")

          candidates_group = candidates.group_by { |party| party.political_party }.map { |party, candidate|
            {
              id: party.id,
              serial_number: party.serial_number,
              name: party.name,
              acronym: party.acronym,
              logo: party.logo,
              actor_type: "Partai",
              candidates: candidate.map { |c|
                {
                  id: c.id,
                  name: c.name,
                  gender: c.gender,
                  serial_number: c.serial_number,
                  actor_type: "Candidate",
                  dapil: {
                    id: c.dapil.id,
                    nama: c.dapil.nama,
                    tingkat: c.dapil.tingkat,
                  },
                  political_party: {
                    id: c.political_party.id,
                    serial_number: c.political_party.serial_number,
                    name: c.political_party.name,
                    acronym: c.political_party.acronym,
                    logo: c.political_party.logo,
                  },
                }
              },
            }
          }
        end
        present candidates_group
      end
    end
  end
end
