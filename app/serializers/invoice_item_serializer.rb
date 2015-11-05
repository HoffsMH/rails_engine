class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def total
    object.unit_price * object.quantity
  end
end
