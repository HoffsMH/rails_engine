require 'rails_helper'
require 'support/gen_merchant'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  test_basic_endpoints(Merchant)
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

  describe "#invoices" do
    context "when given valid params" do
      it "it returns the merchant's invoices" do
        merchant = create(:merchant)
        create(:invoice, merchant_id: merchant.id)
        create(:invoice)
        create(:invoice, merchant_id: merchant.id)
        create(:invoice)


        get :invoices, format: :json, merchant_id: merchant.id

        expect(response.body).to include("\"merchant_id\":#{merchant.id}")
        expect(json.count).to eq(2)
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        merchant = create(:merchant)
        create(:invoice, merchant_id: merchant.id)
        create(:invoice)
        create(:invoice, merchant_id: merchant.id)
        create(:invoice)

        get :invoices, format: :json, merchant_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#most_revenue" do
    context "when given valid params" do
      it "it returns merchants ranked by revenue" do
        data_set = gen_merchants(20)

        get :most_revenue, format: :json, quantity: 4

        expect(response.status).to eq(200)
        expect(json.count).to eq(4)
      end
    end
  end

  describe "#most_items" do
    context "when given valid params" do
      it "it returns merchants ranked by items" do
        data_set = gen_merchants(20)

        get :most_items, format: :json, quantity: 4

        expect(response.status).to eq(200)
        expect(json.count).to eq(4)
      end
    end
  end

  describe "#revenue" do
    context "when given valid params" do
      it "it returns total revenue" do
        data_set = gen_merchants(20)

        get :revenue, format: :json, date: Time.now.to_s

        expect(response.status).to eq(200)
      end
    end
  end


  describe "#merchant_revenue" do
    context "when given valid params" do
      it "it returns total revenue for a merchant" do
        data_set = gen_merchants(20)

        get :merchant_revenue, format: :json, id: data_set[:merchants].first.id

        expect(response.status).to eq(200)
      end
    end
  end

  describe "#favorite_customer" do
    context "when given valid params" do
      it "it returns favorite_customer for a merchant" do
        data_set = gen_merchants(20)

        get :favorite_customer, format: :json, id: data_set[:merchants].first.id

        expect(response.status).to eq(200)
      end
    end
  end

  describe "#customers_with_pending_invoices" do
    context "when given valid params" do
      it "it returns customers with pending invoices" do
        data_set = gen_merchants(20)

        get :customers_with_pending_invoices, format: :json, id: data_set[:merchants].first.id

        expect(response.status).to eq(200)
      end
    end
  end


end
