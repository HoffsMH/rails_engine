class Api::V1::TransactionsController < Api::V1::BaseApiController
  def object_type
    Transaction
  end

  def invoice
    respond_with Transaction.find_by(id: transaction_params[:transaction_id]).invoice
  end


  private
  def transaction_params
    params.permit(:transaction_id)
  end
end
