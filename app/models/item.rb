class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  def most_revenue(rankings)
    thing1 = Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").
                joins(invoices: :transactions).
                joins(:invoice_items).
                merge(InvoiceItem.successful).
                group('merchants.id').
                order("revenue DESC")
    thing1.first(rankings)
  end
end
