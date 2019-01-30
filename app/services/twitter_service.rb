class TwitterService
  attr_accessor :crowling, :twitter, :results

  def initialize(crowling)
    @twitter  = $twitter
    @crowling = crowling
    @results  = []
  end

  def user_timeline(crowling = @crowling)
    unless @crowling.present?
      crowling = @crowling
    end

    options = {}
    if crowling.feeds.present?
      options = { since_id: @crowling.feeds.order(source_id: :DESC).first.source_id }
    end
    @results = @twitter.user_timeline(options.merge({ count: 200, screen_name: crowling.keywords, tweet_mode: "extended" }))
  end

  def create!
    @results.each do |tw|
      cr             = @crowling.feeds.new
      cr.source_id   = tw.id
      cr.source_text = JSON.parse(tw.to_json)["full_text"] || tw.full_text
      if tw.media.present?
        cr.source_media = tw.media.map { |media| media.media_url_https.to_s }
      end
      cr.team = @crowling.team
      cr.type = :TwTimelineFeed

      cr.account_id                = tw.user.id
      cr.account_name              = tw.user.name
      cr.account_username          = tw.user.screen_name
      url                          = URI.parse("https://pbs.twimg.com/profile_images/501884182545457152/iSqdvLul_200x200.oke") #tw.user.profile_image_url
      files                        = url.path.split("/").last.split("_")
      ext                          = files.last.split(".").last
      profile_picture              = URI.join("https://pbs.twimg.com", (url.path.split("/").reverse.drop(1).reverse + [(files.reverse.drop(1).reverse + ["200x200.#{ext}"]).join("_")]).join("/"))
      cr.account_profile_image_url = profile_picture

      cr.created_at = tw.created_at
      begin
        cr.save
      rescue ActiveRecord::RecordNotUnique
        cache = @crowling.feeds.only_deleted.find_by(source_id: tw.id)
        if cache.present?
          cache.restore
        else
          next
        end
      else
        next
      end
    end
  end
end
