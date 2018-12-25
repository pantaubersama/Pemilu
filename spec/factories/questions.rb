FactoryBot.define do
  factory :question do
    body { Faker::Lorem.sentence(3) }
    user_id { "1036fd3c-04ed-4949-b57c-b7dc8ff3e737" }

    trait :reindex do
      after(:create) do |question, _evaluator|
        question.reindex(refresh: true)
      end
    end

  end
end
