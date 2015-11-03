class Api::V1::MerchantsController < ApplicationController

  respond_to :json
  def index
    respond_with object_type.all
  end

  def show
    respond_with object_type.find_by(id: show_params)
  end

  def find
    respond_with  object_type.find_by(find_params)
  end

  private
  def object_type
    Merchant
  end

  def show_params
    params.require(:id)
  end

  def find_params
    merchant_params = object_type.column_names.map {|name| name.to_sym}
    params.permit(*merchant_params)
  end
end
