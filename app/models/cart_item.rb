class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  money_column :price, currency: 'CAD'

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cart, :product, presence: true

  before_save :update_total

  def price
    if persisted?
      self[:price]
    else
      product.price
    end
  end

  def update_total
    self[:price] = product.price
    self[:total] = quantity * self[:price]
  end
end
