require 'rails_helper'
require 'support/basic_endpoints'

RSpec.describe Api::V1::ItemsController, type: :controller do
  test_basic_endpoints(Item)
  describe "#invoice items" do
    context "when given valid params" do
      it "it returns the item's invoice items" do
        item = create(:item)
        create(:invoice_item, item_id: item.id)
        invoice_item = create(:invoice_item, item_id: item.id)

        get :invoice_items, format: :json, item_id: item.id
        binding.pry
      end
    end
  end
end
