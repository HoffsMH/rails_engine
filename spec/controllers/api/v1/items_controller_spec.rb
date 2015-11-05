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


  describe "#merchant" do
    context "when given valid params" do
      it "it returns the item's merchant" do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)

        get :merchant, format: :json, item_id: item.id

        expect(response.body).to include("\"id\":#{merchant.id}")
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)

        get :merchant, format: :json, item_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#most_revenue" do
    context "when given valid params" do
      it "it returns items with the most revenue" do
        data_set = gen_merchants(20)

        get :most_revenue, format: :json, quantity: 1

        expect(response.status).to eq(200)
      end
    end
  end

  describe "#most_items" do
    context "when given valid params" do
      it "it returns items with the most sold" do
        data_set = gen_merchants(20)

        get :most_items, format: :json, quantity: 1

        expect(response.status).to eq(200)
      end
    end
  end

  describe "#best_day" do
    context "when given valid params" do
      it "it returns an items  best day" do
        data_set = gen_merchants(20)
        merchant = data_set[:merchants].first
        item = create(:item, merchant_id: merchant.id)

        get :best_day, format: :json, id: item.id

        expect(response.status).to eq(200)
      end
    end
  end


end
