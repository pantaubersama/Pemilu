class AddLinkToKenalans < ActiveRecord::Migration[5.2]
  def change
    add_column :kenalans, :link, :string
  end
end
