class ViolationReport::Report < ApplicationRecord
  include Reportable

  acts_as_votable
  searchkick callbacks: :async, text_middle: [:all_fields]

  has_one :detail, dependent: :destroy, required: true

  accepts_nested_attributes_for :detail

  validates :reporter_id, presence: true
  validates :dimension_id, presence: true
  validates :title, presence: true
  validates :description, presence: true

  scope :recent, -> { order created_at: :desc, updated_at: :desc }

  delegate :reportee, to: :detail, allow_nil: true

  def reporter
    @reporter ||= User.find(reporter_id)
  end

  def search_data
    index_all.merge!(
      detail: detail.index_all.merge!(
        reportee: reportee.index_all,
        witnesses: detail.witnesses.map(&:index_all),
        evidences: detail.evidences.map(&:index_all)
      ),
      reporter: {
        id: reporter.id,
        email: reporter.email,
        username: reporter.username,
        verified: reporter.verified,
        avatar: reporter.avatar,
        full_name: reporter.full_name,
        about: reporter.about,
        cluster: reporter.cluster
      },
      all_fields: [
        '--',
        title,
        description,
        reporter.username,
        reporter.full_name,
        detail.location,
        detail.occurrence_time,
        reportee.name,
        '--'
      ].compact.join(' ')
    )
  end
end
