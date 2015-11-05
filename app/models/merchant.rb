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

  def self.most_items(rankings)
    merchant_items = Invoice.successful.joins(:invoice_items).
    includes(:merchant).
    group(:merchant).
    sum("quantity")

    sorted = merchant_items.sort_by do |merchant, items|
      items
    end.reverse
    sorted.first(rankings).map do |merchant, items|
      merchant
    end
  end

  def self.revenue(date)
    rev = Invoice.successful.joins(:invoice_items).where(invoices: {created_at: date}).
    sum("quantity * unit_price")
    {total_revenue: rev}
  end

  def revenue(date=nil)
    if date
      rev = invoices.successful.joins(:invoice_items).where(invoices: {created_at: date}).
      sum("quantity * unit_price")
      {revenue: rev}
    else
      rev = invoices.successful.joins(:invoice_items).
      sum("quantity * unit_price")
      {revenue: rev}
    end
  end
end
