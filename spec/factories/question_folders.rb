FactoryBot.define do
  factory :question_folder do
    name { Faker::Lorem.words(2) }
  end
end
