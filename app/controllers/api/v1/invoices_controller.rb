class Api::V1::InvoicesController < Api::V1::BaseApiController
  def object_type
    Invoice
  end

  def items
    binding.pry
    respond_with Item.where(invoice_params)
  end

  def invoice_items
    respond_with InvoiceItem.where(invoice_params)
  end

  def invoices
    respond_with Invoice.where(invoice_params)
  end

  private
  def invoice_params
    params.permit(:invoice_id)
  end
end
