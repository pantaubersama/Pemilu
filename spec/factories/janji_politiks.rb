FactoryBot.define do
  factory :janji_politik do
    user_id { "1036fd3c-04ed-4949-b57c-b7dc8ff3e737" }
    image { Rack::Test::UploadedFile.new 'spec/fixtures/files/janji_image.jpg', 'image/jpg' }
  end
end
