module API::V2::Helpers
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
      en: (Time.now.to_i - date.to_i > 172800) ? (I18n.l(date, format: "%b %d, %Y", locale: :en) unless date.nil?) : (time_ago_in_words(date, {include_seconds: false, highest_measure_only: 2, locale: :en}) + " ago"),
      id: (Time.now.to_i - date.to_i > 172800) ? (I18n.l(date, format: "%b %d, %Y", locale: :id) unless date.nil?) : (time_ago_in_words(date, {include_seconds: false, highest_measure_only: 2, locale: :id}) + " yang lalu")
    }
  end
end