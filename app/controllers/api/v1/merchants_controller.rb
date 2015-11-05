class Api::V1::MerchantsController < Api::V1::BaseApiController
  def object_type
    Merchant
  end

  def items
    items =  Item.where(merchant_params)
    !items.empty? ? respond_with(items) : not_found
  end

  def invoices
    invoices =  Invoice.where(merchant_params)
    !invoices.empty? ? respond_with(invoices) : not_found
  end

  def most_revenue
    top_merchants = Merchant.most_revenue(rankings)
    !top_merchants.empty? ? respond_with(top_merchants) : not_found
  end

  def most_items
    top_merchants = Merchant.most_items(rankings)
    !top_merchants.empty? ? respond_with(top_merchants) : not_found
  end

  def revenue
    rev = Merchant.revenue(date)
    rev ? respond_with(rev) : not_found
  end

  def merchant_revenue
    merchant = Merchant.find_by(id: merchant_id)
    rev = merchant.revenue(date)
    rev ? respond_with(rev) : not_found
  end

  def favorite_customer
    merchant = Merchant.find_by(id: merchant_id)
    favorite = merchant.favorite_customer
    favorite ? respond_with(favorite) : not_found
  end

  def customers_with_pending_invoices
    merchant = Merchant.find_by(id: merchant_id)
    pending = merchant.customers_with_pending_invoices
    pending ? respond_with(pending) : not_found
  end



  private
  def merchant_params
    params.permit(:merchant_id)
  end

  def rankings
    params.permit(:quantity)[:quantity].to_i
  end

  def date
    params.permit(:date)[:date]
  end

  def merchant_id
    merchant_params[:merchant_id] || params.permit(:id)[:id]
  end

end
