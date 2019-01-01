FactoryBot.define do
  factory :quiz_answer do
    team_id { 1 }
    content { Faker::Lorem.words(3) }
    quiz_question { FactoryBot.create :quiz_question }
  end
end
