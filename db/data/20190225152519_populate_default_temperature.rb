class PopulateDefaultTemperature < SeedMigration::Migration
  def up
    Question.find_each do |question|
      question.update_attributes({
        temperature: 1,
        last_temperature_at: Time.now.utc
      })
    end
  end

  def down

  end
end
