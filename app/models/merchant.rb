class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(rankings)
    merchant_revenues = Invoice.successful.joins(:invoice_items).
                         includes(:merchant).
                         group(:merchant).
                         sum("quantity * unit_price")

    sorted = merchant_revenues.sort_by do |merchant, revenue|
      revenue
    end.reverse

    sorted.first(rankings).map do |merchant, revenue|
      merchant
    end
  end

  def revenue
    Invoice.successful.where(merchant_id: id).revenue
  end
end
