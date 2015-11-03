class Api::V1::CustomersController < Api::V1::BaseApiController
  def object_type
    Transaction
  end

  private
  def transaction_params
    params.permit(:transaction_id)
  end
end
