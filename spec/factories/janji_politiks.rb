FactoryBot.define do
  factory :janji_politik do
    title { "Pengadaan Bunker Anti Bencana" }
    body { "Pada 2019, di wacanakan bunker anti bencana siap di resmikan." }
    user_id { "1036fd3c-04ed-4949-b57c-b7dc8ff3e737" }

    trait :reindex do
      after(:create) do |question, _evaluator|
        question.reindex(refresh: true)
      end
    end
  end

end
