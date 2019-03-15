module API::V1::Hitung::Summary::Resources
  class Candidates < API::V1::ApplicationResource
    resource "summary" do
      desc "perhitungan caleg" do
        detail "perhitungan caleg
                level : <br>
                0 => DPR RI <br>
                1 => DPRD Provinsi <br>
                2 => DPRD Kabupaten / Kota <br>
                3 => DPD <br>
               "
      end
      params do
        requires :dapil_id, type: Integer
        requires :level, type: Integer, values: (0..3).to_a
        optional :hitung_real_count_id, type: String
      end
      get "candidates/show" do
        hitung = ::Hitung::CalegSummary.new params.level, params.dapil_id, params.hitung_real_count_id
        result, invalid_vote, valid_vote = hitung.run
        present :invalid_vote, invalid_vote, using: API::V1::Hitung::Summary::Entities::Candidate
        present :valid_vote, valid_vote, using: API::V1::Hitung::Summary::Entities::Candidate
        present :percentages, result, using: API::V1::Hitung::Summary::Entities::Candidate
      end

    end
  end
end
