class Api::V1::InvoiceItemsController < ApplicationController
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
    respond_with Invoice.find_by(id: invoice_params[:invoice_id]).customer
  end

  def merchant
    respond_with Invoice.find_by(id: invoice_params[:invoice_id]).merchant
  end

  private
  def invoice_params
    params.permit(:invoice_id)
  end
end
