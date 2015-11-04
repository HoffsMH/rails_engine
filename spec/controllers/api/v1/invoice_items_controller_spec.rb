require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  test_basic_endpoints(InvoiceItem)
  describe "#invoice" do
    context "when given valid params" do
      it "it returns invoice_item's invoice" do
        merchant = create(:merchant)
        invoice = create(:invoice, merchant_id: merchant.id)
        create(:invoice_item, invoice_id: invoice.id)
        create(:invoice_item, invoice_id: invoice.id)
        invoice_item = create(:invoice_item, invoice_id: invoice.id)

        get :invoice, format: :json, invoice_item_id: invoice_item.id

        expect(response.body).to include("\"merchant_id\":#{merchant.id}")
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        merchant = create(:merchant)
        invoice = create(:invoice, merchant_id: merchant.id)
        create(:invoice_item, invoice_id: invoice.id)
        create(:invoice_item, invoice_id: invoice.id)
        invoice_item = create(:invoice_item, invoice_id: invoice.id)

        get :invoice, format: :json, invoice_item_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end

end
