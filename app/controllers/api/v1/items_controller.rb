class Api::V1::ItemsController < Api::V1::BaseApiController
  def object_type
    Item
  end

  def invoice
    respond_with InvoiceItem.find_by(id: invoice_items_params[:invoice_item_id]).invoice
  end

  def item
    respond_with InvoiceItem.find_by(id: invoice_items_params[:invoice_item_id]).item
  end

  private
  def items_params
    params.permit(:item_id)
  end
end
