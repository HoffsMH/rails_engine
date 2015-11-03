class Api::V1::CustomersController < Api::V1::BaseApiController
  def object_type
    Customer
  end

  def invoices
    respond_with Customer.find_by(id: customer_params[:customer_id]).invoices
  end

  def transactions
    respond_with Customer.find_by(id: customer_params[:customer_id]).transactions
  end

  private
  def customer_params
    params.permit(:customer_id)
  end
end
