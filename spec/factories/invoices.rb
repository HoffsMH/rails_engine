FactoryGirl.define do
  factory :invoice do
    customer
    merchant
    status ["shipped"].sample
  end
end
