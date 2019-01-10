class CartSerializer < ActiveModel::Serializer
  attributes :id, :total, :status
  has_many :cart_items
end
