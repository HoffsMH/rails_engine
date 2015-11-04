require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "all merchants" do
    describe "#most_revenue" do
      it "returns the top x merchant ranked by total revenue" do
        100.times do
          create(:merchant)
        end
        binding.pry
      end
    end
  end
end
