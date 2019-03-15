module Hitung
  class Summary
    attr_accessor :calculation

    def percentage_of x, total
      ((x.to_f / total) * 100).round(3)
    end

  end
end
