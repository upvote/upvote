FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    headline { Faker::Lorem.sentence }
    avatar Faker::Avatar.image(Faker::Lorem.sentence.parameterize.first(10), '48x48')
  end
end
