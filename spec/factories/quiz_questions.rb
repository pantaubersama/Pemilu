FactoryBot.define do
  factory :quiz_question do
    content { Faker::Lorem.words(5) }
    quiz { FactoryBot.create :quiz }
  end
end
