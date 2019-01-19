module Publishable

  #
  # I expect you to create field `is_published` type `boolean` default `false`
  #

  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(is_published: true) }
    scope :not_published, -> { where(is_published: false) }
  end

  def publish!
    update_attribute :is_published, true
  end

  def unpublish!
    update_attribute :is_published, false
  end
  

  class_methods do
    
  end
end