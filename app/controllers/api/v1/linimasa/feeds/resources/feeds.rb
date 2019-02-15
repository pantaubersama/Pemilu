class API::V1::Linimasa::Feeds::Resources::Feeds < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "feeds" do
    desc "List feed pilpres", headers: OPTIONAL_AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      use :filter, filter_by: ["", "team_all", "team_id_1", "team_id_2", "team_id_3", "team_id_4"]
      optional :q, type: String
      optional :username, type: String
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get :pilpres do
      query = "*"
      if params.q.present?
        query = "#{params.q}"
      end

      default_order    = { created_at: { order: :desc, unmapped_type: "long" } }
      build_conditions = params.filter_by.present? ? team_filter(params.filter_by) : {}
      if params.username.present?
        build_conditions = build_conditions.merge({account_username: params.username})
      end
      resources        = Feed.search(query, match: :text_middle, misspellings: false, load: false, page: (params.page || 1), per_page: (params.per_page || Pagy::VARS[:items]), order: default_order, where: build_conditions)

      present :feeds, resources, with: API::V1::Linimasa::Feeds::Entities::Feed
      present_metas_searchkick resources
    end

    desc "Detail feed pilpres", headers: AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      requires :id
    end
    get "pilpres/:id" do
      resource = Feed.find(params.id)
      present :feed, resource, with: API::V1::Linimasa::Feeds::Entities::Feed
    end

    desc "List trash feeds", headers: AUTHORIZATION_HEADERS
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    get :trashes do
      authorize_admin!
      feeds     = Feed.deleted
      resources = paginate(feeds)
      present :feeds, resources, with: API::V1::Linimasa::Feeds::Entities::Feed
      present_metas resources
    end

    desc "Detail trash pilpres", headers: AUTHORIZATION_HEADERS
    optional_oauth2
    params do
      requires :id
    end
    get "trash/:id" do
      resource = Feed.deleted.find(params.id)
      present :feed, resource, with: API::V1::Linimasa::Feeds::Entities::Feed
    end

    desc "Delete Feed", headers: AUTHORIZATION_HEADERS
    oauth2
    params do
      requires :id, type: String
    end
    delete do
      authorize_admin!
      feed = Feed.find(params.id)
      unless feed.delete
        error!(feed.errors.full_messages.join(", "), 422)
      end
      response = { message: "Feed id #{params.id} berhasil dihapus" }
      present response
    end

    desc "Generate feed"
    oauth2
    params do
      requires :feeds, type: Array do
        requires :id, type: String, desc: "Tweet ID"
        requires :full_text, type: String, desc: "Tweet full text"
        requires :team_id, type: Integer, desc: "1 Tim jokowi-ma`ruf`, 2 Tim prabowo-sandi, 3 KPU, 4 Bawaslu"
        optional :media, type: Array do
          requires :id, type: String, desc: "media ID"
          requires :media_url_https, type: String, desc: "media URL https"
        end
        requires :user, type: Hash do
          requires :id, type: String, desc: "User ID"
          requires :name, type: String, desc: "User name"
          requires :name, type: String, desc: "User name"
          requires :screen_name, type: String, desc: "User screen_name"
          requires :profile_image_url, type: String, desc: "User profile image url"
        end
        requires :created_at, type: String, desc: "created_at"
      end
    end
    post do
      errors = []
      params.feeds.each do |tw|
        cr             = Feed.new
        cr.source_id   = tw.id
        cr.crowling_id = tw.crowling_id
        cr.source_text = tw.full_text
        if tw.media.present?
          cr.source_media = tw.media.map { |media| media.media_url_https.to_s }
        end
        cr.team = tw.team_id
        cr.type = :TwTimelineFeed

        cr.account_id                = tw.user.id
        cr.account_name              = tw.user.name
        cr.account_username          = tw.user.screen_name
        cr.account_profile_image_url = tw.user.profile_image_url.to_s

        cr.created_at = tw.created_at
        begin
          cr.save
        rescue ActiveRecord::RecordNotUnique
          cache = Feed.only_deleted.find_by(source_id: tw.id)
          if cache.present?
            cache.restore
          else
            errors << tw.id
            next
          end
        else
          next
        end
      end
      response = { message: "Success Created feeds" }
      if errors.present?
        response = { message: "Gagal menyimpan feed ids #{errors}" }
      end
      present response
    end

  end
end
