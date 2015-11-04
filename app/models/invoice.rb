class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items

  def self.successful
    joins(:transactions).where(transactions: {result: "success"})
  end

  def self.revenue
    joins(:invoice_items).sum("quantity * unit_price")
  end

  def successful
    transactions
  end
end
