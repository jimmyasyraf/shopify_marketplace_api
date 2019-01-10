class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :cart_id, :price, :quantity, :total
end
