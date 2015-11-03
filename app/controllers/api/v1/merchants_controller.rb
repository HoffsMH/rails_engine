class Api::V1::MerchantsController < ApplicationController
  respond_to :json
  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: merchant_params)
  end

  def find

  end
  private
  def merchant_params
    params.require(:id)
  end
end
