class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :inventory_count
end
