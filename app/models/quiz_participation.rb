class QuizParticipation < ApplicationRecord
  include Userable

  acts_as_paranoid
  mount_uploader :image_result, ResultUploader

  enum status: [ :in_progress, :finished ]

  belongs_to :quiz

  has_many :quiz_answerings

  def share_url
    ENV["SHARE_DOMAIN"] + "/share/hasilkuis/" + id
  end
end
