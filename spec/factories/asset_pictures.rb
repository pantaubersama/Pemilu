FactoryBot.define do
  factory :asset_picture do
    picture { Rack::Test::UploadedFile.new 'spec/fixtures/files/janji_image.jpg', 'image/jpg' }
    bucket_title { "janji_politik" }
  end
end
