class CreateQuizParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_participations, id: :uuid do |t|
      t.uuid :quiz_id, index: true
      t.uuid :user_id, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
