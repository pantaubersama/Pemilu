FactoryBot.define do
  factory :candidate do
    name { "MyString" }
    gender { "MyString" }
    political_party_id { 1 }
    electoral_district_id { 1 }
    serial_number { "MyString" }
    original_filename { "MyString" }
  end
end
