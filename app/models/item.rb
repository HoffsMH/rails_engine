class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  def self.most_revenue(rankings)
    revenue_rankings = Item.select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as items_revenue").
                joins(invoices: :transactions).
                joins(:invoice_items).
                merge(InvoiceItem.successful).
                group('items.id').
                order("items_revenue DESC")
    revenue_rankings.first(rankings)
  end

  def self.most_items(rankings)
    item_rankings = Item.select("items.*, count(invoice_items.quantity) as items_count").
                joins(invoices: :transactions).
                joins(:invoice_items).
                merge(InvoiceItem.successful).
                group('items.id').
                order("items_count DESC")
    item_rankings.first(rankings)
  end

  def best_day
    day_rankings = InvoiceItem.successful
      .where("item_id" => id)
      .group("invoices.created_at")
      .order("sum_quantity DESC")
      .sum("quantity")
      if day_rankings && day_rankings.first
        day = day_rankings.first[0]
      else
        day = nil
      end
      {best_day: day}
  end
end
