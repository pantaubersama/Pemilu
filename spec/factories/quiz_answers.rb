FactoryBot.define do
  factory :quiz_answer do
    team { 1 }
    content { Faker::Lorem.words(3) }
    quiz_question { FactoryBot.create :quiz_question }
  end
  factory :quiz_answer_team_1, class: QuizAnswer do
    team { 1 }
    content { Faker::Lorem.words(5) }
    quiz_question { FactoryBot.create :quiz_question }
  end

  factory :quiz_answer_team_2, class: QuizAnswer do
    team { 2 }
    content { Faker::Lorem.words(8) }
    quiz_question { FactoryBot.create :quiz_question }
  end
end
