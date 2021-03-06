class Question < ApplicationRecord
  acts_as_paranoid
  acts_as_votable
  enum status: [:active, :archived]

  validates_length_of :body, minimum: 3, maximum: 260
  validates :user_id, presence: true

  include Reportable
  searchkick  callbacks: :async,
              searchable: [:body],
              word_start: [:body],
              word_middle: [:body],
              word_end: [:body],
              word: [:body]

  include API::V1::Helpers

  belongs_to :question_folder, optional: true, counter_cache: true

  scope :in_folder, -> { archived }
  scope :not_in_folder, -> { active }

  after_create :give_achievement

  ## temperatures
  include Temperatures::Hotness

  hotness_config do
    {
      upvote: 1,
      downvote: 1
    }
  end

  heat_config do
    {
      c: 1
    }
  end

  def give_achievement
    total = Question.where(user_id: user_id).count(:all)
    Publishers::QuestionBadge.publish({user_id: user_id, badge_code: "tanya", total: total})
  end

  def should_index?
    deleted_at.nil?
  end

  def search_data
    {
      share_url:          self.share_url,
      id:                 self.id,
      cached_votes_up:    self.cached_votes_up,
      report_count:       self.report_count,
      body:               self.body,
      created_at:         self.created_at,
      created_at_in_word: self.created_at_in_word,
      status:             self.status,
      user:               {
        email:     self.user.email,
        username:  self.user.username,
        verified:  self.user.verified,
        id:        self.user.id,
        avatar:    self.user.avatar,
        full_name: self.user.full_name,
        about:     self.user.about,
      },
      temperature:                self.temperature,
      last_temperature_at:        self.last_temperature_at,
      epoch_last_temperature_at:  self.last_temperature_at.to_i
    }
  end

  # def created
  #   created_at
  # end


  def user
    User.find self.user_id
  end

  def share_url
    ENV["SHARE_DOMAIN"] + "/share/tanya/" + id
  end

end
