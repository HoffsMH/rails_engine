class Api::V1::ItemsController < Api::V1::BaseApiController
  def object_type
    Item
  end

  def invoice_items
    respond_with InvoiceItem.joins(:item).where(items: {id: item_id})
  end

  def merchant
    respond_with Merchant.joins(:items).find_by(items: {id: item_id})
  end

  private
  def item_params
    params.permit(:item_id)
  end

  def item_id
    item_params[:item_id]
  end
end
