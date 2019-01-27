class QuizPreference < ApplicationRecord
  mount_uploader :image_result, ResultUploader
end
