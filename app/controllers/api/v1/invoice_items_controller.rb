class Api::V1::InvoiceItemsController < Api::V1::BaseApiController
  def object_type
    InvoiceItem
  end

  def invoice
    respond_with Invoice.joins(:invoice_items).find_by(invoice_items: {id: invoice_item_id})
  end

  def item
    respond_with Item.joins(:invoice_items).find_by(invoice_items: {id: invoice_item_id})
  end

  private
  def invoice_item_params
    params.permit(:invoice_item_id)
  end

  def invoice_item_id
    invoice_item_params[:invoice_item_id]
  end
end
