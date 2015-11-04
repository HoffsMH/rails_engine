require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  test_basic_endpoints(InvoiceItem)
  describe "#items" do
    context "when given valid params" do
      it "it returns the merchant's items" do
        merchant = create(:merchant)
        create(:item, merchant_id: merchant.id)
        create(:item)
        create(:item, merchant_id: merchant.id)
        create(:item)


        get :items, format: :json, merchant_id: merchant.id

        expect(response.body).to include("\"merchant_id\":#{merchant.id}")
        expect(json.count).to eq(2)
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        merchant = create(:merchant)
        create(:item, merchant_id: merchant.id)
        create(:item)
        create(:item, merchant_id: merchant.id)
        create(:item)

        get :items, format: :json, merchant_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end

end
