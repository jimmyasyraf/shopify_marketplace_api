class Product < ApplicationRecord
  has_many :order_items
  money_column :price, currency: 'CAD'

  def buy(quantity)
    self[:inventory_count] -= quantity
    self.save
  end
end
