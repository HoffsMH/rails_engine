class Api::V1::MerchantsController < ApplicationController
  def index
    respond_with Merchant.all
  end
end
