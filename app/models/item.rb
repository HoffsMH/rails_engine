class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  def self.most_revenue(rankings)
    thing1 = Item.select("items.*, count(invoice_items.quantity) as items_count").
                joins(invoices: :transactions).
                joins(:invoice_items).
                merge(InvoiceItem.successful).
                group('items.id').
                order("items_count DESC")
    thing1.first(rankings)
  end
end
