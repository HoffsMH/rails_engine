class Api::V1::InvoiceItemsController < Api::V1::BaseApiController
  def object_type
    InvoiceItem
  end



  private
  def invoice_items_params
    params.permit(:invoice_item_id)
  end
end
