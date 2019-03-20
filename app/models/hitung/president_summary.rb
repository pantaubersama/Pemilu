module Hitung
  class PresidentSummary < Hitung::Summary

    def total_vote
      @calculation.map(&:calon_1).sum.to_i + @calculation.map(&:calon_2).sum.to_i + @calculation.map(&:invalid_vote).sum
    end

    def percentage_team_1
      percentage_of(@calculation.map(&:calon_1).sum.to_i, total_vote)
    end

    def percentage_team_2
      percentage_of(@calculation.map(&:calon_2).sum.to_i, total_vote)
    end

    def percentage_invalid_vote
      percentage_of(@calculation.map(&:invalid_vote).sum.to_i, total_vote)
    end

    def run summary_type = "all", id = nil, tps = nil, real_count_id = nil
      str_select = "round(avg(hitung_calculations.invalid_vote)) as invalid_vote,
        round(avg(hitung_calculation_details.total_vote) filter(where actor_type = 'President' and actor_id = '1')) as calon_1,
        round(avg(hitung_calculation_details.total_vote) filter(where actor_type = 'President' and actor_id = '2')) as calon_2"

      @calculation = Hitung::Calculation.joins(:real_count, :details)
        .group("hitung_real_counts.village_code, hitung_real_counts.tps")
        .select(str_select)

      @calculation = case summary_type
      when "province"
        @calculation.where("hitung_real_counts.province_code  = ? ", id)
      when "regency"
        @calculation.where("hitung_real_counts.regency_code  = ? ", id)
      when "district"
        @calculation.where("hitung_real_counts.district_code  = ? ", id)
      when "village"
        @calculation.where("hitung_real_counts.village_code  = ? ", id)
      when "tps"
        @calculation.where("hitung_real_counts.village_code  = ? ", id).
          where("hitung_real_counts.tps = ?" , tps)
      when "perseorangan"
        @calculation.where("hitung_real_counts.village_code  = ? ", id).
          where("hitung_real_counts.tps = ?" , tps).
          where("hitung_real_counts.id = ? ", real_count_id)
      else
        @calculation
      end

      if @calculation.present?
        h = {
          summary_type: summary_type,
          candidates: [
            {
              id: 1,
              total_vote: @calculation.map(&:calon_1).sum.to_i,
              percentage: percentage_team_1
            },
            {
              id: 2,
              total_vote: @calculation.map(&:calon_2).sum.to_i,
              percentage: percentage_team_2
            }
          ],
          invalid_vote: {
            total_vote: calculation.map(&:invalid_vote).sum,
            percentage: percentage_invalid_vote
          },
          total_vote: total_vote
        }
      else
        nil
      end
    end

  end
end
