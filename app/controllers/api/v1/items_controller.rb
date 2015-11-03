class Api::V1::ItemsController < Api::V1::BaseApiController
  def object_type
    Item
  end

  def invoice_items
    respond_with Item.find_by(id: item_params[:item_id]).invoice_items
  end

  def merchant
    respond_with Item.find_by(id: item_params[:item_id]).merchant
  end

  private
  def item_params
    params.permit(:item_id)
  end
end
