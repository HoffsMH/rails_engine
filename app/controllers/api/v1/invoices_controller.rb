class Api::V1::InvoicesController < Api::V1::BaseApiController
  def object_type
    Invoice
  end

  def items
    respond_with Item.joins(:invoice_items).where(invoice_items: invoice_params)
  end

  def invoice_items
    respond_with InvoiceItem.where(invoice_params)
  end

  def transactions
    respond_with Transaction.where(invoice_params)
  end

  def customer
    respond_with Customer.find_by(invoice_params)
  end

  private
  def invoice_params
    params.permit(:invoice_id)
  end
end
