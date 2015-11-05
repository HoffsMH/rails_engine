class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  def self.most_revenue(rankings)
    output = Item.select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as items_revenue").
                joins(invoices: :transactions).
                joins(:invoice_items).
                merge(InvoiceItem.successful).
                group('items.id').
                order("items_revenue DESC")
    output.first(rankings)
  end

  def self.most_items(rankings)
    output = Item.select("items.*, count(invoice_items.quantity) as items_count").
                joins(invoices: :transactions).
                joins(:invoice_items).
                merge(InvoiceItem.successful).
                group('items.id').
                order("items_count DESC")
    output.first(rankings)
  end
end
