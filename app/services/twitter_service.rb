class TwitterService
  attr_accessor :crowling, :twitter, :results

  def initialize(crowling)
    @twitter       = $twitter
    @crowling      = crowling
    @results       = []
  end

  def user_timeline(crowling = @crowling)
    unless @crowling.present?
      crowling = @crowling
    end

    options = {}
    if crowling.feeds.present?
      options = { since_id: @crowling.feeds.order(source_id: :DESC).first.source_id }
    end
    @results       = @twitter.user_timeline(options.merge({ count: 200, screen_name: crowling.keywords }))
  end

  def create!
    @results.each do |tw|
      cr             = @crowling.tw_timeline_feeds.new
      cr.source_id   = tw.id
      cr.source_text = tw.full_text

      cr.account_id                = tw.user.id
      cr.account_name              = tw.user.name
      cr.account_username          = tw.user.screen_name
      cr.account_profile_image_url = tw.user.profile_image_url.to_s

      cr.created_at = tw.created_at
      cr.save
    end

  end
end

