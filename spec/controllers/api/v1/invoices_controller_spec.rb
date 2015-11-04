require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  test_basic_endpoints(Invoice)
  describe "#items" do
    context "when given valid params" do
      it "it returns the invoice's items" do
        invoice = create(:invoice)

        item1 = create(:item)
        item2 = create(:item)

        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
        invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)


        get :items, format: :json, invoice_id: invoice.id

        expect(response.body).to include("\"id\":#{item1.id}")
        expect(json.count).to eq(2)
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        invoice = create(:invoice)

        item1 = create(:item)
        item2 = create(:item)

        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
        invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)

        get :items, format: :json, invoice_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#invoice_items" do
    context "when given valid params" do
      it "it returns the invoice's invoice_items" do
        invoice = create(:invoice)

        item1 = create(:item)
        item2 = create(:item)

        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
        invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)


        get :invoice_items, format: :json, invoice_id: invoice.id

        expect(response.body).to include("\"item_id\":#{item1.id}")
        expect(json.count).to eq(2)
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        invoice = create(:invoice)

        item1 = create(:item)
        item2 = create(:item)

        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
        invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)

        get :invoice_items, format: :json, invoice_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#transactions" do
    context "when given valid params" do
      it "it returns the invoice's transactions" do
        invoice = create(:invoice)

        item1 = create(:item)
        item2 = create(:item)

        transaction1 = create(:transaction, invoice_id: invoice.id)
        transaction2 = create(:transaction, invoice_id: invoice.id)

        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
        invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)


        get :transactions, format: :json, invoice_id: invoice.id

        expect(response.body).to include("\"invoice_id\":#{invoice.id}")
        expect(json.count).to eq(2)
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        invoice = create(:invoice)

        item1 = create(:item)
        item2 = create(:item)

        transaction1 = create(:transaction, invoice_id: invoice.id)
        transaction2 = create(:transaction, invoice_id: invoice.id)

        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
        invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)

        get :transactions, format: :json, invoice_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end

end
