module API::V1
  module SharedParams
    extend Grape::API::Helpers

    params :order do |options|
      optional :order_by, type: String, values: (options[:order_by].map { |x| x.to_s} + [""]).uniq, default: options[:default_order_by].to_s || "", desc: "[Order] by"
      optional :direction, type: String, values: ["", "asc", "desc"], default: options[:default_order].to_s, desc: "[Order] Direction"
    end

    params :filter do |options|
      optional :filter_by, type: String, values: (options[:filter_by].map { |x| x.to_s} + [""]).uniq, default: options[:default_filter_by].to_s || "", desc: "[Filter] by"
      # optional :filter_value, type: String, values: options[:filter_value], desc: "Filter value"
    end

    params :searchkick_search do |options|
      optional :q, type: String, default: "*", documentation: { desc: "[Search] Keyword" }
      optional :o, type: String, values: ["", "or", "and"], default: options[:default_o].to_s, documentation: { desc: "[Search] Operator" }
      optional :m, type: String, values: ["", "word_start", "word_middle", "word_end", "word"], default: options[:default_m].to_s, documentation: { desc: "[Search] Match" }
    end
  end
end
