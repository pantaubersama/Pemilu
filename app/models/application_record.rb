class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def created_at_in_word
    date = created_at
    {
      iso_8601: date,
      en:       (Time.zone.now.to_i - date.to_i > 172800) ? (I18n.l(date, format: "%b %d, %Y", locale: :en) unless date.nil?) : (time_ago_in_words(date, { include_seconds: false, highest_measure_only: 2, locale: :en }) + " ago"),
      id:       (Time.zone.now.to_i - date.to_i > 172800) ? (I18n.l(date, format: "%b %d, %Y", locale: :id) unless date.nil?) : (time_ago_in_words(date, { include_seconds: false, highest_measure_only: 2, locale: :id }) + " yang lalu")
    }
  end

  def column_names
    eval(self.class.name).column_names.delete_if { |x| [:deleted_at, "deleted_at"].include?(x) } + ["created_at_in_word"]
  end
end
