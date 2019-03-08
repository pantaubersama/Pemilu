class Hitung::Calculation < ApplicationRecord
  enum calculation_type: [:dpr, :provinsi, :kabupaten, :dpd, :presiden]

  belongs_to :real_count, foreign_key: :hitung_real_count_id
  has_many :details, class_name: "Hitung::CalculationDetail", foreign_key: :hitung_calculation_id, dependent: :destroy

  def candidates
    details.where(actor_type: ["Candidate", "President"])
  end

  def parties
    details.where(actor_type: "Party")
  end
  accepts_nested_attributes_for :details

  def save_all! params
    candidates_params = params.candidates.map do |x|
      x[:hitung_real_count_id] =  params.hitung_real_count_id
      x[:calculation] =  self
      x[:actor_type] = params.calculation_type == "presiden" ? "President" : "Candidate"
      x[:actor_id] = x[:id]
      x.delete(:id)
      x
    end

    parties_params = []
    if params.parties.present?
      parties_params = params.parties.map do |x|
        x[:hitung_real_count_id] =  params.hitung_real_count_id
        x[:calculation] =  self
        x[:actor_type] = "Party"
        x[:actor_id] = x[:id]
        x.delete(:id)
        x
      end unless params.calculation_type == "presiden" && params.calculation_type == "dpd"
    end

    self.invalid_vote = params.invalid_vote

    details.delete_all
    details.build(candidates_params)
    details.build(parties_params) if parties_params.size > 0

    status = self.save!

    [status, self]
  end

end
