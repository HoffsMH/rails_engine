require 'rails_helper'
require 'support/basic_endpoints'

RSpec.describe Api::V1::CustomersController, type: :controller do
  test_basic_endpoints(Customer)
  describe "#invoices" do
    context "when given valid params" do
      it "it returns the item's invoice items" do
        customer = create(:customer)
        create(:invoice, customer_id: customer.id)
        invoice = create(:invoice, customer_id: customer.id)

        get :invoices, format: :json, customer_id: customer.id

        expect(response.body).to include("\"customer_id\":#{customer.id}")
        expect(json.count).to eq(2)
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        customer = create(:customer)
        create(:invoice, customer_id: customer.id)
        invoice = create(:invoice, customer_id: customer.id)

        get :invoices, format: :json, customer_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end
end
