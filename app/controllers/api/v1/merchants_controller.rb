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
    top_merchants = Merchant.most_revenue(rankings)
    !top_merchants.empty? ? respond_with(top_merchants) : not_found
  end

  private
  def merchant_params
    params.permit(:merchant_id)
  end
  def rankings
    params.permit(:quantity)[:quantity].to_i
  end
end
