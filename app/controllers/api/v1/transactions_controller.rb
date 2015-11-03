class Api::V1::TransactionsController < Api::V1::BaseApiController
  def object_type
    Transaction
  end

  def invoice
    respond_with Invoice.joins(:transactions).where(transactions: {id: transaction_id})
  end

  private
  def transaction_params
    params.permit(:transaction_id)
  end

  def transaction_id
    transaction_params[:transaction_id]
  end
end
