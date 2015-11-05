require 'rails_helper'
require 'support/gen_merchant'

RSpec.describe Merchant, type: :model do
  context "all merchants" do
    describe "#most_revenue" do
      it "returns the top x merchant ranked by total revenue" do
        data_set = gen_merchants(50)
        result = Merchant.most_revenue(3)

        expect(result.count).to eq(3)
        expect(result[0].revenue[:revenue]).to be > result[1].revenue[:revenue]
        expect(result[1].revenue[:revenue]).to be > result[2].revenue[:revenue]
      end
    end

    describe "#most_items" do
      it "returns the top x merchant ranked by total items sold" do
        data_set = gen_merchants(50)
        result = Merchant.most_items(3)

        expect(result.count).to eq(3)
      end
    end

    describe "#revenue" do
      it "returns revenue for all merchants" do
        data_set = gen_merchants(50)
        sample_date = data_set[:merchants].sample.created_at.to_s

        result = Merchant.revenue(sample_date)


        # expect(result[:total_revenue].is_a? Numeric).to be_true
        expect(result[:total_revenue]).to be_a_kind_of(Numeric)
      end
    end

  end
end
