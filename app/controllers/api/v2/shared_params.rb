module API::V2
  module SharedParams
    extend Grape::API::Helpers
  
    params :order do |options|
      optional :order_by, type: String, values: options[:order_by], default: options[:default_order_by]
      optional :direction, type: String, values: ["", "asc", "desc"], default: options[:default_order]
    end

    params :filter do |options|
      optional :filter_by, type: String, values: options[:filter_by], default: options[:default_filter_by]
      # optional :filter_value, type: Symbol, values: options[:filter_value]
    end
  end
end