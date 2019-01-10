class Product < ApplicationRecord
  has_many :order_items
  money_column :price, currency: 'CAD'
end
