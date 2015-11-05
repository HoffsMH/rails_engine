class Api::V1::CustomersController < Api::V1::BaseApiController
  def object_type
    Customer
  end

  def invoices
    invoices = Invoice.where(customer_id: customer_id)
    !invoices.empty? ? respond_with(invoices) : not_found
  end

  def transactions
    transactions =  Transaction.joins(:invoice).where(invoices:{customer_id: customer_id})
    !transactions.empty? ? respond_with(transactions) : not_found
  end

  def favorite_merchant
    customer = Customer.find_by(id: customer_id)

    favorite = customer.favorite_merchant
    favorite ? respond_with(favorite) : not_found
  end

  private
  def customer_params
    params.permit(:customer_id)
  end

  def customer_id
    customer_params[:customer_id] || params.permit(:id)[:id]
  end
end
