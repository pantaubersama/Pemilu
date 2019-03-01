class CustomJSON
  def self.parse input
    output = []

    ids = input.map(&:id).compact.map(&:to_i)
    totals = input.map(&:total).compact.map(&:to_i)

    ids.each_with_index do |i, index|
      output << {
        id: i,
        total: totals[index]
      }
    end

    output
  end
end

module API::V1::Hitung::Counter::Resources
  class Counter < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams

    resource "counter" do

      desc "Create / update Counter" do
        detail <<~DESCRIPTION
          Create / update Counter
          <br>
          Request example :
          <br>
          ```
            {
              "hitung_real_count_id": "YOUR_UUID",
              "counter_type": "presiden",
              "invalid_vote": 111,
              "candidates": [
                {
                  "id": 1,
                  "total": 123
                },
                {
                  "id": 2,
                  "total": 234
                },
                "parties": [
                  {
                    "id": 1,
                    "total": 123
                  },
                  {
                    "id": 2,
                    "total": 234
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
        requires :counter_type, type: String, values: ["dpr", "provinsi", "kabupaten", "dpd", "presiden"]
        requires :invalid_vote, type: Integer, default: 0
        requires :candidates, type: Array, coerce_with: CustomJSON do
          requires :id, type: Integer, desc: 'Candidate ID'
          requires :total, type: Integer, desc: 'Total votes'
        end
        optional :parties, type: Array, coerce_with: CustomJSON do
          optional :id, type: String, desc: 'Party ID'
          optional :total, type: Integer, desc: 'Total votes'
        end
      end
      put "/" do
        params
      end

    end

    # permitted params
    helpers do

    end

  end
end
