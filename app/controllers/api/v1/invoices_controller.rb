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
    respond_with Customer.joins(:invoices).where(invoices: {id: invoice_id})
  end

  def merchant
    respond_with Merchant.joins(:invoices).where(invoices: {id: invoice_id})
  end

  private
  def invoice_params
    params.permit(:invoice_id)
  end

  def invoice_id
    invoice_params[:invoice_id]
  end
end
