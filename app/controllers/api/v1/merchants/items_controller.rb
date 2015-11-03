class Api::V1::Merchants::ItemsController < ApplicationController
  def object_type
    Item
  end

  def index
    binding.pry

  end
  private
  def merchant_params
    params.permit()
  end
end
