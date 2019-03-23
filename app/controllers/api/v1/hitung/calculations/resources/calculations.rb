class CustomJSON
  def self.parse input
    output = []

    ids = input.map(&:id).compact.map(&:to_i)
    totals = input.map(&:total_vote).compact.map(&:to_i)

    ids.each_with_index do |i, index|
      output << {
        id: i,
        total_vote: totals[index]
      }
    end

    output
  end
end

module API::V1::Hitung::Calculations::Resources
  class Calculations < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "calculations" do

      desc "Display saved calculation" do
        detail "Display saved calculation"
        headers AUTHORIZATION_HEADERS
      end
      params do
        requires :hitung_real_count_id, type: String
        requires :calculation_type, type: String, values: ["dpr", "provinsi", "kabupaten", "dpd", "presiden"]
      end
      oauth2
      get "/" do
        check_real_count_ownership! current_user, params.hitung_real_count_id

        hitung = ::Hitung::RealCount.find params.hitung_real_count_id
        calculation = ::Hitung::Calculation.find_by hitung_real_count_id: params.hitung_real_count_id,
          calculation_type: params.calculation_type

        error! "Belum ada perhitungan", 404 if calculation.nil?

        present :calculation, calculation, with: API::V1::Hitung::Calculations::Entities::Calculation
      end

      desc "Create / update calculation" do
        detail <<~DESCRIPTION
          Create / update calculation
          <br>
          Request example :
          <br>
          ```
            {
              "hitung_real_count_id": "YOUR_UUID",
              "calculation_type": "presiden",
              "invalid_vote": 111,
              "candidates": [
                {
                  "id": 1,
                  "total_vote": 123
                },
                {
                  "id": 2,
                  "total_vote": 234
                }
              ],
              "parties": [
                {
                  "id": 1,
                  "total_vote": 123
                },
                {
                  "id": 2,
                  "total_vote": 234
                }
              ]
            }
          ```
        DESCRIPTION
        headers AUTHORIZATION_HEADERS
      end
      oauth2
      params do
        requires :hitung_real_count_id, type: String
        requires :calculation_type, type: String, values: ["dpr", "provinsi", "kabupaten", "dpd", "presiden"]
        requires :invalid_vote, type: Integer, default: 0
        requires :candidates, type: Array, coerce_with: CustomJSON do
          requires :id, type: Integer, desc: 'Candidate ID'
          requires :total_vote, type: Integer, desc: 'Total votes'
        end
        optional :parties, type: Array, coerce_with: CustomJSON do
          optional :id, type: String, desc: 'Party ID'
          optional :total_vote, type: Integer, desc: 'Total votes'
        end
      end
      put "/" do
        check_real_count_ownership! current_user, params.hitung_real_count_id

        hitung = ::Hitung::RealCount.find params.hitung_real_count_id

        if params.calculation_type == "presiden"
          ids = params.candidates.map(&:id)
          error! "ID Presiden = 1 atau 2", 422 unless ids.include?(1) && ids.include?(2)
        else
          dapil = Dapil.by_wilayah params.calculation_type, hitung.province, hitung.regency, hitung.district
          caleg = Candidate.where(electoral_district_id: dapil.id).map(&:id)

          not_found = params.candidates.map(&:id) - caleg
          error! "Caleg ID #{not_found} bukan bagian dari Dapil #{dapil.nama} [#{dapil.id}]", 422 if not_found.size > 0
        end

        calculation = ::Hitung::Calculation.find_or_initialize_by hitung_real_count_id: params.hitung_real_count_id,
          calculation_type: params.calculation_type

        status = calculation.save_all! params
        present :status, status[0]
        present :calculation, status[1], with: API::V1::Hitung::Calculations::Entities::Calculation
      end

    end

    # permitted params
    helpers do

    end

  end
end
