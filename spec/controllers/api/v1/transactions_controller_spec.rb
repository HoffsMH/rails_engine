require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  test_basic_endpoints(Transaction)
  describe "#invoice" do
    context "when given valid params" do
      it "it returns the transaction's invoice" do
        invoice = create(:invoice)
        transaction = create(:transaction, invoice_id: invoice.id)

        get :invoice, format: :json, transaction_id: transaction.id

        expect(response.body).to include("\"id\":#{invoice.id}")
      end
    end

    context "when given invalid params" do
      it "it returns 404 status and an error message" do
        invoice = create(:invoice)
        transaction = create(:transaction, invoice_id: invoice.id)

        get :invoice, format: :json, transaction_id: 9929992

        expect(response.body).to include("not found")
        expect(response.status).to eq(404)
      end
    end
  end

end
