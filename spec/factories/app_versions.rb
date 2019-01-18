FactoryBot.define do
  factory :app_version do
    name { "1.0.0" }
    force_update { false }
    app_type { "android" }
  end
end
