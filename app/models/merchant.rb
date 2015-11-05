class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.most_revenue(rankings)
    revenue_rankings = Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").
                joins(invoices: :transactions).
                joins(:invoice_items).
                merge(InvoiceItem.successful).
                group('merchants.id').
                order("revenue DESC")
    revenue_rankings.first(rankings)
  end

  def self.most_items(rankings)
    item_rankings = Merchant.select("merchants.*, sum(invoice_items.quantity) as items_count").
                joins(:invoice_items).
                group('merchants.id').
                order("items_count DESC").
                merge(InvoiceItem.successful)
    item_rankings.first(rankings)
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

  def favorite_customer
    # favorite = invoices.successful.joins(:transactions).group(:customer_id).count(:transactions)
    favorites = customers.select("customers.*, count(invoices.customer_id) as favorites").
              joins(invoices: :transactions).
              merge(Transaction.successful).
              group("customers.id").
              order("favorites desc").first
  end

  def customers_with_pending_invoices
    customer_ids = invoices.unpaid.joins(:customer).pluck(:customer_id)
    customer_ids.map do |customer_id|
      Customer.find_by(id: customer_id)
    end
  end
end
