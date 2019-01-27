class AddResultToQuizParticipation < ActiveRecord::Migration[5.2]
  def change
    add_column :quiz_participations, :image_result, :string
  end
end
