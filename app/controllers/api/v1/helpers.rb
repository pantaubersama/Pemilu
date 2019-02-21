module API::V1::Helpers
  # meta response
  def present_metas resources
    total_pages  = resources.total_pages
    limit_value  = params.limit_value || params.per_page || Pagy::VARS[:max_per_page]
    current_page = params.current_page || params.page || 1
    present :meta, { total_pages: total_pages, limit_value: limit_value, current_page: current_page }, with: API::V1::Metas::Entities::Meta
  end

  def present_metas_searchkick resources
    total_pages  = (resources.total_count.to_f / (params.per_page || Pagy::VARS[:max_per_page])).ceil
    limit_value  = params.per_page || Pagy::VARS[:max_per_page]
    current_page = params.page || 1
    present :meta, { total_pages: total_pages, limit_value: limit_value, current_page: current_page }, with: API::V1::Metas::Entities::Meta
  end

  def prepare_file(f)
    ActionDispatch::Http::UploadedFile.new(f)
  end

  def permitted_params(params)
    ActionController::Parameters.new(params)
  end

  def friendly_date date
    zone      = ActiveSupport::TimeZone.new("Asia/Jakarta")
    date      = date.in_time_zone(zone)
    now       = Time.zone.now
    time_lang = {}
    ["en", "id"].each do |lang|
      time_lang[lang] = if (now.to_i - date.to_i > 2.days.to_i) && (now.to_i - date.to_i < 1.year.to_i)
                          I18n.l(date, format: "%d %b", locale: lang) unless date.nil?
                        elsif ((now.to_i - date.to_i) > 1.year.to_i)
                          (I18n.l(date, format: "%d %b %y", locale: lang) unless date.nil?)
                        else
                          (time_ago_in_words(date, { include_seconds: false, highest_measure_only: 2, locale: lang }) + "")
                        end
    end
    {
      time_zone: "Asia/Jakarta",
      iso_8601:  date,
    }.merge(time_lang)
  end

  def authorize_admin!
    error!("Tidak dapat mengakses API", 403) if current_user.nil? || !current_user.is_admin
  end
  def authorize_voter!
    error!("Tidak dapat mengakses API", 403) if current_user.nil? || !["surveymanual", :surveymanual].include?(current_user.username)
  end

  def authorize_eligible_user!
    error!("Tidak dapat mengakses API", 403) unless (current_user.cluster.present? && current_user.cluster.is_eligible)
  end

  def question_filter(x)
    case x
    when "user_verified_true"
      { "user.verified" => true }
    when "user_verified_false"
      { "user.verified" => false }
    when "user_verified_all"
      {}
    else
      {}
    end
  end

  def team_filter(x)
    #team_all team_id_1 team_id_2
    case x
    when "team_id_1"
      { team: 1 }
    when "team_id_2"
      { team: 2 }
    when "team_id_3"
      { team: 3 }
    when "team_id_4"
      { team: 4 }
    when "team_all"
      {}
    else
      {}
    end
  end

  def quiz_filter(x)
    { quiz_participations: { status: x.to_s } }
  end

end
