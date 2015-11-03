class Api::V1::CustomersController < Api::V1::BaseApiController
  def object_type
    Customer
  end

  def invoices
    respond_with Invoice.where(customer_id: customer_id)
  end

  def transactions
    respond_with Transaction.joins(:invoice).where(invoices:{customer_id: customer_id})
  end

  private
  def customer_params
    params.permit(:customer_id)
  end

  def customer_id
    customer_params[:customer_id]
  end
end
