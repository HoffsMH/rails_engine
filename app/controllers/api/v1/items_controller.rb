class Api::V1::ItemsController < Api::V1::BaseApiController
  def object_type
    Item
  end

  private
  def item_params
    params.permit(:item_id)
  end
end
