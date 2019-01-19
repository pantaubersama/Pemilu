class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def created_at_in_word
    date = created_at
    {
      iso_8601: date,
      en: (
        if (Time.now.to_i - date.to_i > 2.days.to_i) && (Time.now.to_i - date.to_i < 1.year.to_i)
          I18n.l(date, format: "%d %b", locale: :en) unless date.nil?
        elsif (Time.now.to_i - date.to_i > 1.year.to_i)
          (I18n.l(date, format: "%d %b %y", locale: :en) unless date.nil?)
        else
          (time_ago_in_words(date, { include_seconds: false, highest_measure_only: 2, locale: :en }) + "")
        end
      ),
      id: (
        if (Time.now.to_i - date.to_i > 2.days.to_i) && (Time.now.to_i - date.to_i < 1.year.to_i)
          I18n.l(date, format: "%d %b", locale: :id) unless date.nil?
        elsif (Time.now.to_i - date.to_i > 1.year.to_i)
          (I18n.l(date, format: "%d %b %y", locale: :id) unless date.nil?)
        else
          (time_ago_in_words(date, { include_seconds: false, highest_measure_only: 2, locale: :id }) + "")
        end
      )
    }
  end

  def column_names
    eval(self.class.name).column_names.delete_if { |x| [:deleted_at, "deleted_at"].include?(x) } + ["created_at_in_word"]
  end
end
