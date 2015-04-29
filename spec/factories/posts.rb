FactoryGirl.define do
  factory :post, class: Post::Link do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    url { Faker::Internet.url }
  end
end
