class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def created_at_in_word
    zone      = ActiveSupport::TimeZone.new("Asia/Jakarta")
    date      = created_at.in_time_zone(zone)
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

  def index_all
    attributes.except(:deleted_at).merge({created_at_in_word: self.created_at_in_word})
  end
end
