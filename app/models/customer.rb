class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    favorites = merchants.select("merchants.*, count(invoices.merchant_id) as favorites").
              joins(invoices: :transactions).
              merge(Transaction.successful).
              group("merchants.id").
              order("favorites desc")
              
    !favorites.to_a.empty? ? favorites.first : {favorite_merchant: nil}
  end
end
