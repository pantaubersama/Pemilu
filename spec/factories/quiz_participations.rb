FactoryBot.define do
  factory :quiz_participation do
    quiz_id { FactoryBot.create :quiz }
    status { 1 }
  end
end
