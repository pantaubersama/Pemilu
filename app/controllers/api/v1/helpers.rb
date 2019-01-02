module API::V1::Helpers
  # meta response
  def present_metas resources
    total_pages  = resources.count
    limit_value  = params.per_page
    current_page = params.page
    present :meta, { total_pages: total_pages, limit_value: limit_value, current_page: current_page }, with: API::V1::Metas::Entities::Meta
  end

  def prepare_file(f)
    ActionDispatch::Http::UploadedFile.new(f)
  end

  def permitted_params(params)
    ActionController::Parameters.new(params)
  end

  def friendly_date date
    {
        iso_8601: date,
        en:       (Time.now.to_i - date.to_i > 172800) ? (I18n.l(date, format: "%b %d, %Y", locale: :en) unless date.nil?) : (time_ago_in_words(date, { include_seconds: false, highest_measure_only: 2, locale: :en }) + " ago"),
        id:       (Time.now.to_i - date.to_i > 172800) ? (I18n.l(date, format: "%b %d, %Y", locale: :id) unless date.nil?) : (time_ago_in_words(date, { include_seconds: false, highest_measure_only: 2, locale: :id }) + " yang lalu")
    }
  end

  def authorize_admin!
    error!("Tidak dapat mengakses API", 403) unless current_user.is_admin
  end

  def authorize_eligible_user!
    error!("Tidak dapat mengakses API", 403) unless (current_user.cluster.present? && current_user.cluster.is_eligible)
  end

  def question_filter(x)
    case x
    when :user_verified_true
      { "user.verified" => true }
    when :user_verified_false
      { "user.verified" => false }
    when :user_verified_all
      {}
    else
      {}
    end
  end

  def team_filter(x)
    #team_all team_id_1 team_id_2
    case x
    when :team_id_1
      { team: 1 }
    when :team_id_2
      { team: 2 }
    when :team_all
      {}
    else
      {}
    end
  end

  def quiz_filter(x)
    { quiz_participations: { status: x.to_s } }
  end

end