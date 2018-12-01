module CoreExtensions
  module ActiveRecord
    module Relation
      # Make positional finder methods (i.e. #first) to use a more sensible
      # default order column (e.g. +created_at+) instead of a non-sequential
      # primary key (e.g. type of UUID).
      #
      # == Coverage
      #
      # The patch is applied to the following methods along with their bang
      # version (i.e. #first!):
      # * #first
      # * #last
      # * #second
      # * #third
      # * #fourth
      # * #fifth
      # * #forty_two
      # * #third_to_last
      # * #second_to_last
      #
      # == Column priority
      #
      # The first of the following columns if exists will be used in ORDER BY
      # clause:
      # 1. +created_at+
      # 2. +created_on+
      # 3. +updated_at+
      # 4. +updated_on+
      #
      # == Example
      #
      #   # Fetches with ORDER BY created_at ASC
      #   Person.first
      #   Person.first(2)
      #   Person.first!
      #   Person.first!(2)
      #   Person.all.first
      #   Person.all.first(2)
      #   Person.all.first!
      #   Person.all.first!(2)
      #
      #   # Fetches with ORDER BY age ASC
      #   Person.order(:age).first
      #   Person.order(:age).first(2)
      #   Person.order(:age).first!
      #   Person.order(:age).first!(2)
      module PreferredDefaultOrder
        PREFERRED_COLUMNS = %w[created_at created_on updated_at updated_on].freeze
        NON_SEQUENTIAL_TYPES = [:uuid].freeze
        METHODS = %i[first last second third fourth fifth forty_two third_to_last second_to_last].freeze

        METHODS.each do |method_name|
          define_method method_name do |*args|
            apply_preferred_order! if order_values.empty?
            super(*args)
          end
        end

        private

        def apply_preferred_order!
          return if primary_key && NON_SEQUENTIAL_TYPES.exclude?(columns_hash[primary_key]&.type)
          column = (PREFERRED_COLUMNS & column_names).first
          order! arel_attribute(column).asc if column
        end
      end
    end
  end
end

ActiveRecord::Relation.include CoreExtensions::ActiveRecord::Relation::PreferredDefaultOrder
