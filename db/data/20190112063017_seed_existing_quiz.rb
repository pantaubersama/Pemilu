class SeedExistingQuiz < SeedMigration::Migration
  def up
    Quiz.find_each do |quiz|
      if quiz.is_published == true
        quiz.published!
      else
        quiz.draft!
      end
    end
  end

  def down

  end
end
