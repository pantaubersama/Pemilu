class AddVersionCodeToAppVersion < ActiveRecord::Migration[5.2]
  def change
    add_column :app_versions, :version_code, :integer
  end
end
