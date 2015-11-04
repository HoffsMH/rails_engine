FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity { Random.rand(1..10) }
    unit_price { Random.rand(1000..100000) }
  end
end
