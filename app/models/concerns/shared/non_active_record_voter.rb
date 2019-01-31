require 'active_support/concern'

module Shared::NonActiveRecordVoter
  extend ActiveSupport::Concern

  class_methods do
    def base_class
      self
    end

    def polymorphic_name
      base_class.name
    end

    def primary_key
      'id'
    end
  end

  def _read_attribute attr
    send attr
  end
end
