class Api::V1::CustomersController < Api::V1::BaseApiController
  def object_type
    Customer
  end

  private
  def customer_params
    params.permit(:customer_id)
  end
end
