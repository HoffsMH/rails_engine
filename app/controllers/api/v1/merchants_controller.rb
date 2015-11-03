class Api::V1::MerchantsController < Api::V1::BaseApiController
  def object_type
    Merchant
  end

  def items
    respond_with Item.where(merchant_params)
  end

  def invoices
    respond_with Invoice.where(merchant_params)
  end

  private
  def merchant_params
    params.permit(:merchant_id)
  end
end
