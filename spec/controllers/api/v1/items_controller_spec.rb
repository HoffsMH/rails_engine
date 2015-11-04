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

        expect(response.body).to include("\"item_id\":#{item.id}")
        expect(json.count).to eq(2)
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        item = create(:item)
        create(:invoice_item, item_id: item.id)
        invoice_item = create(:invoice_item, item_id: item.id)

        get :invoice_items, format: :json, item_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end
end
