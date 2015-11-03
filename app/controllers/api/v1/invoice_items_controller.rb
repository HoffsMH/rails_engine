class Api::V1::InvoiceItemsController < Api::V1::BaseApiController
  def object_type
    InvoiceItem
  end

  def invoice
    respond_with InvoiceItem.find_by(id: invoice_items_params[:invoice_item_id]).invoice
  end

  def item
    respond_with InvoiceItem.find_by(id: invoice_items_params[:invoice_item_id]).item
  end

  private
  def invoice_items_params
    params.permit(:invoice_item_id)
  end
end
