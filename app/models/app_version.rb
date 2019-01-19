class AppVersion < ApplicationRecord
  enum app_type: [ :android, :ios ]
end
