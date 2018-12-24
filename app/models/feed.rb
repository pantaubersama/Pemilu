class Feed < ApplicationRecord
  belongs_to :crowling

  def team_text
    [1, "1"].include?(team) ? "Jokowi - Makruf" : "Prabowo - Sandi"
  end

  def trash
    only_deleted
  end
end
