FactoryGirl.define do
  factory :post_base, class: Post::Base do
    user
    title { Faker::Lorem.sentence }
  end

  factory :post, class: Post::Link, parent: :post_base, aliases: [:link_post] do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    url { Faker::Internet.url }
  end

  factory :text_post, class: Post::Text, parent: :post_base do
    description { Faker::Lorem.sentence }
  end
end
