FactoryGirl.define do
  factory :comment do
    user
    commentable { create :post }
    body { Faker::Lorem.sentence }
  end
end
