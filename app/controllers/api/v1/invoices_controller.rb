class Api::V1::InvoicesController < Api::V1::BaseApiController
  def object_type
    Invoice
  end

  def items
    items =  Item.joins(:invoice_items).where(invoice_items: invoice_params)
    !items.empty? ? respond_with(items) : not_found
  end

  def invoice_items
    invoice_items = InvoiceItem.where(invoice_params)
    !invoice_items.empty? ? respond_with(invoice_items) : not_found
  end

  def transactions
    transactions = Transaction.where(invoice_params)
    !transactions.empty? ? respond_with(transactions) : not_found
  end

  def customer
    customer = Customer.joins(:invoices).find_by(invoices: {id: invoice_id})
    customer ? respond_with(customer) : not_found
  end

  def merchant
    merchant = Merchant.joins(:invoices).find_by(invoices: {id: invoice_id})
    merchant ? respond_with(merchant) : not_found
  end

  private
  def invoice_params
    params.permit(:invoice_id)
  end

  def invoice_id
    invoice_params[:invoice_id]
  end
end
