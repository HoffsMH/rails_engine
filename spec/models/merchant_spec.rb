require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "all merchants" do
    describe "#most_revenue" do
      it "returns the top x merchant ranked by total revenue" do
        100.times do
          merchant = create(:merchant)
          invoice = create(:invoice, merchant_id: merchant.id)
          create(:transaction, invoice_id: invoice.id, result: "success")
          create(:invoice_item, invoice_id: invoice.id)
          create(:invoice_item, invoice_id: invoice.id)
          create(:invoice_item, invoice_id: invoice.id)
          create(:invoice_item, invoice_id: invoice.id)
        end
        result = Merchant.most_revenue(2)

        expect(result.count).to eq(2)
        expect(result.count).to eq(2)

      end
    end
  end
end
