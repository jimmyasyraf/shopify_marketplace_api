class Cart < ApplicationRecord
  has_many :cart_items

  enum status: [:open, :checked_out]

  before_save :update_total

  def update_total
    total = cart_items.collect { |item| item.valid? ? (item.quantity * item.price) : 0}.sum
    self[:total] = total
  end
end
