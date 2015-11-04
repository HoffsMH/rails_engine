class Api::V1::InvoiceItemsController < Api::V1::BaseApiController
  def object_type
    InvoiceItem
  end

  def invoice
    invoice = Invoice.joins(:invoice_items).find_by(invoice_items: {id: invoice_item_id})
    invoice ? respond_with(invoice) : not_found
  end
  end

  def item
    item = Item.joins(:invoice_items).find_by(invoice_items: {id: invoice_item_id})
    item ? respond_with(item) : not_found
  end

  private
  def invoice_item_params
    params.permit(:invoice_item_id)
  end

  def invoice_item_id
    invoice_item_params[:invoice_item_id]
  end
end
