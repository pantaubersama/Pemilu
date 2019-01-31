FactoryBot.define do
  factory :user do
    to_create { |instance| ElasticModelStubber.stub_user_record instance }

    id { SecureRandom.uuid }
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    username { nil }

    avatar {
      { url: nil,
        thumbnail: { url: nil },
        thumbnail_square: { url: nil },
        medium: { url: nil },
        medium_square: { url: nil }
      }
    }

    verified { false }
    is_admin { false }
    is_moderator { false }
    cluster { nil }
    about { nil }

    trait :verified do
      verified { true }
    end

    trait :admin do
      is_admin { true }
    end

    trait :clustered do
      cluster { { id: SecureRandom.uuid } }
    end

    factory :verified_user, traits: [:verified]
    factory :admin, traits: [:admin]
    factory :clustered_user, traits: [:clustered]
  end
end
