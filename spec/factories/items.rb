FactoryGirl.define do
  factory :item do
    name Faker::Commerce.product_name
    description Faker::Lorem.sentence(3)
    merchant
  end
end
