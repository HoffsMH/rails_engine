class Api::V1::TransactionsController < Api::V1::BaseApiController
  def object_type
    Transaction
  end

  def invoice
    invoice =  Invoice.joins(:transactions).find_by(transactions: {id: transaction_id})
    invoice ? respond_with(invoice) : not_found
  end

  private
  def transaction_params
    params.permit(:transaction_id)
  end

  def transaction_id
    transaction_params[:transaction_id]
  end
end
