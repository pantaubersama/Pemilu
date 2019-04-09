module Hitung
  class CalegSummary < Hitung::Summary

    attr_accessor :calculation_type, :dapil_id, :real_count_id

    def initialize ct, di, rci = nil
      @calculation_type = ct
      @dapil_id = di
      @real_count_id = rci
    end

    def run
      invalid_vote = run_invalid_vote

      candidates = []
      parties = []

      run_total_vote_caleg.each do |caleg|
        candidates << decorate_caleg(caleg)
      end
      summed_candidates = candidates.group_by { |k| k[:id] }.values
      summed_candidates.map! {|first, *rest|
        if rest.empty?
          first
        else
          first.dup.tap {|f|
            rest.each {|h| f[:cv] += h[:cv]}}
        end
      }

      run_total_vote_party.each do |party|
        parties << decorate_party(party, summed_candidates.select{|caleg| caleg[:political_party_id].to_i == party.actor_id.to_i})
      end
      summed_parties = parties.group_by { |k| k[:id] }.values
      summed_parties.map! {|first, *rest|
        if rest.empty?
          first
        else
          first.dup.tap {|f|
            rest.each {|h| f[:pv] += h[:pv]}}
        end
      }
      summed_parties.map! {|party| party.dup.tap {|p|
          p[:total_vote] = p[:pv] + p[:tcv]
        }
      }
      if calculation_type == 3
        valid_vote = summed_candidates.map{|k| k[:cv]}.sum
        output = summed_candidates.map! {|candidate|
          candidate[:total_vote] = candidate[:cv]
          candidate
        }
      else
        valid_vote = summed_parties.map{|k| k[:total_vote]}.sum
        output = summed_parties
      end

      output.map! {|party| party.dup.tap {|p|
          p[:percentage] = percentage_of(p[:total_vote], valid_vote + invalid_vote )
        }
      }

      iv = {
        total_vote: invalid_vote,
        percentage: percentage_of(invalid_vote, valid_vote + invalid_vote)
      }
      [output, iv, valid_vote]
    end

    def run_invalid_vote
      str_select = "round(avg(hitung_calculations.invalid_vote)) as invalid_vote, hitung_real_counts.village_code, hitung_real_counts.tps"

      hitung = Hitung::Calculation.joins(:real_count)
        .group("hitung_real_counts.village_code, hitung_real_counts.tps")
        .select(str_select)
        .where(dapil_id: @dapil_id, calculation_type: @calculation_type)
        .where("hitung_real_counts.status = 1")
        .where("hitung_calculations.calculation_type != 4")

      hitung = hitung.where("hitung_real_counts.id = ? ", @real_count_id) if @real_count_id.present?
      hitung.map(&:invalid_vote).sum
    end

    def run_total_vote_caleg
      str_select = "hitung_real_counts.village_code, hitung_real_counts.tps, candidates.political_party_id, hitung_calculation_details.actor_id, hitung_calculation_details.actor_type, candidates.name as actor_name, candidates.serial_number as actor_serial_number, round(avg(hitung_calculation_details.total_vote)) as avg_total_vote"
      str_group = "hitung_real_counts.village_code, hitung_real_counts.tps, candidates.political_party_id, hitung_calculation_details.actor_id, hitung_calculation_details.actor_type, candidates.political_party_id, actor_name, actor_serial_number"
      hitung = Hitung::CalculationDetail.joins(:calculation => [:real_count])
        .joins("inner join candidates on cast(hitung_calculation_details.actor_id as integer) = cast(candidates.id as integer)")
        .where("hitung_real_counts.status = 1 and hitung_calculation_details.actor_type = 'Candidate' and hitung_calculations.dapil_id = ? and hitung_calculations.calculation_type = ?", @dapil_id, @calculation_type)
        .where("hitung_calculations.calculation_type != 4")
        .select(str_select)
        .group(str_group)
        .order("candidates.political_party_id asc")

      hitung = hitung.where("hitung_real_counts.id = ? ", @real_count_id) if @real_count_id.present?
      hitung
    end

    def run_total_vote_party
      str_select = "hitung_real_counts.village_code, hitung_real_counts.tps, hitung_calculation_details.actor_id, hitung_calculation_details.actor_type, political_parties.name, political_parties.serial_number, political_parties.logo, round(avg(hitung_calculation_details.total_vote)) as avg_total_vote"
      str_group = "hitung_real_counts.village_code, hitung_real_counts.tps, hitung_calculation_details.actor_id, hitung_calculation_details.actor_type, political_parties.name, political_parties.serial_number, political_parties.logo"
      hitung = Hitung::CalculationDetail.joins(:calculation => [:real_count])
        .joins("inner join political_parties on cast(hitung_calculation_details.actor_id as integer) = cast(political_parties.id as integer)")
        .where("hitung_real_counts.status = 1 and hitung_calculation_details.actor_type = 'Party' and hitung_calculations.dapil_id = ? and hitung_calculations.calculation_type = ?", @dapil_id, @calculation_type)
        .where("hitung_calculations.calculation_type != 4")
        .select(str_select)
        .group(str_group)

      hitung = hitung.where("hitung_real_counts.id = ? ", @real_count_id) if @real_count_id.present?
      hitung
    end

    def decorate_caleg caleg
      {
        id: caleg.actor_id,
        name: caleg.actor_name,
        serial_number: caleg.actor_serial_number,
        cv: caleg.avg_total_vote.to_i,
        political_party_id: caleg.political_party_id
      }
    end

    def decorate_party party, candidates
      {
        id: party.actor_id.to_i,
        serial_number: party.serial_number,
        name: party.name,
        logo: party.logo,
        pv: party.avg_total_vote.to_i,
        tcv: candidates.map{|c| c[:cv]}.sum,
        candidates: candidates
      }
    end

  end
end
