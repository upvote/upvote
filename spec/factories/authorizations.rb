FactoryGirl.define do
  factory :authorization do
    provider { User.omniauth_providers.map(&:to_s).sample }
    user
    handle { Faker::Internet.user_name }
    uid { SecureRandom.hex }
  end

  factory :facebook_authorization, parent: :authorization do
    provider 'facebook'
  end

  factory :twitter_authorization, parent: :authorization do
    provider 'twitter'
  end

  factory :github_authorization, parent: :authorization do
    provider 'github'
  end
end
