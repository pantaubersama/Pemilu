module Temperatures
  module Hotness
    extend ActiveSupport::Concern
    # include Reputations::Increment

    included do
      # == config

      self.half_life = 8
      self.t0 = 1
      self.hotness_variables = {}
      self.heat_variables = {}

      # == config


      before_create :initial_temperature

      default_scope {
        select_append("( #{self.table_name.to_s}.temperature * (#{self.cooling_rate_sql}) ) as hot_score")
      }
    end

    def initial_temperature
      self.temperature = self.class.t0
      self.last_temperature_at = self.created_at
    end

    def current_temperature
      self.hot_score
    end


    # == formula

    def cooling_rate
      Math.exp(-set_lambda * last_reading)
    end

    def set_lambda
      0.693 / self.class.half_life
    end

    def last_reading
      (Time.now.utc - self.last_temperature_at) / 3600
    end

    def delta_t(q, m)
      q / (m * self.class.heat_variables[:c])
    end

    # == formula


    # == trigger
    def increase_temperature(addition)
      self.with_lock do
        t = self.temperature * self.cooling_rate
        # for the sake of simplicity, we increase heat by 10 (10 / 1 * 1)
        # no reputation needed
        q = 10
        dt = delta_t(q, addition)
        t += dt
        self.temperature = t.round(10)
        self.last_temperature_at = Time.now.utc
        self.save!
      end
    end

    def decrease_temperature(reduction)
      self.with_lock do
        t = self.temperature * self.cooling_rate
        # for the sake of simplicity, we decrease heat by 9 (9 / 1 * 1)
        # no reputation needed
        q = 9
        dt = delta_t(q, reduction)
        t -= dt
        self.temperature = t.round(10)
        self.last_temperature_at = Time.now.utc
        self.save!
      end
    end

    # == trigger



    class_methods do

      # == config

      attr_accessor :half_life, :t0, :hotness_variables, :heat_variables

      def hotness_config
        hotness_variables.merge!(yield)
      end

      def heat_config
        heat_variables.merge!(yield)
      end

      # == config


      # == formula (in postgresql)

      def cooling_rate_sql
        "EXP( -(#{self.set_lambda_sql}) * #{self.last_reading_sql} )"
      end

      def set_lambda_sql
        "0.693 / #{self.half_life}"
      end

      def last_reading_sql
        now = "now() at time zone 'utc'"
        last_touch = "#{self.table_name}.last_temperature_at"
        "( ( extract (epoch from (#{now} - #{last_touch}))::integer ) / 3600 )"
      end

      # == formula (in postgresql)


      # == formula (in elasticsearch)

      def hot_score_es direction
        {
          type: "number",
          order: direction,
          script: {
            source: "doc['temperature'].value * (#{self.cooling_rate_es})",
            params: {
              now: Time.now.utc.to_i
            }
          }
        }
      end

      def cooling_rate_es
        "Math.exp(-(#{self.set_lambda_es}) * (#{self.last_reading_es}) )"
      end

      def set_lambda_es
        "0.693 / #{self.half_life}"
      end

      def last_reading_es
        "(params.now - doc['epoch_last_temperature_at'].value) / 3600"
      end

      # == formula (in elasticsearch)
    end

  end
end
