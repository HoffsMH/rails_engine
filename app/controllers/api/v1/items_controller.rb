class Api::V1::ItemsController < Api::V1::BaseApiController
  def object_type
    Item
  end

  def invoice_items
    invoice_items = InvoiceItem.joins(:item).where(items: {id: item_id})
    !invoice_items.empty? ? respond_with(invoice_items) : not_found
  end

  def merchant
    merchant = Merchant.joins(:items).find_by(items: {id: item_id})
    merchant ? respond_with(merchant) : not_found
  end

  def most_revenue
    top_items = Item.most_revenue(rankings)
    !top_items.empty? ? respond_with(top_items) : not_found
  end

  def most_items
    top_items = Item.most_items(rankings)
    !top_items.empty? ? respond_with(top_items) : not_found
  end

  def best_day
    item = Item.find_by(id: item_id)
    best_day = item.best_day
    best_day ? respond_with(best_day) : not_found
  end

  private
  def item_params
    params.permit(:item_id)
  end

  def item_id
    item_params[:item_id] || params.permit(:id)[:id]
  end

  def rankings
    params.permit(:quantity)[:quantity].to_i
  end
end
