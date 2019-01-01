FactoryBot.define do
  factory :quiz do
    title { Faker::Lorem.words(3) }
    description { Faker::Lorem.words(5) }
    image { Rack::Test::UploadedFile.new 'spec/images/html.png', 'image/png' }
    quiz_questions_count { 0 }
  end
end
