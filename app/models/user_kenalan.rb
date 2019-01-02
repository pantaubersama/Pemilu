class UserKenalan < ApplicationRecord
  belongs_to :kenalan
  validates_presence_of :user_id, :kenalan_id
  before_create :set_action_at

  def is_action
    action_at.present?
  end

  private

  def set_action_at
    self.action_at = Time.zone.now
  end
end
