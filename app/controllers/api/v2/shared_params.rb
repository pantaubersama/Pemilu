module API::V2
  module SharedParams
    extend Grape::API::Helpers
  
    params :order do |options|
      optional :order_by, type: Symbol, values: options[:order_by], default: options[:default_order_by]
      optional :direction, type: Symbol, values: %i(asc desc), default: options[:default_order]
    end
  end
end