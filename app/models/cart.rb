class Cart < ApplicationRecord
  include AASM

  has_many :cart_items

  before_save :update_total

  enum status: [:open, :checked_out]

  aasm column: :status, enum: true do
    state :open, initial: true
    state :checked_out

    event :checkout, :after => :complete_checkout  do
      transitions :from => :open, :to => :checked_out
    end
  end

  def update_total
    total = cart_items.collect { |item| item.valid? ? (item.quantity * item.price) : 0}.sum
    self[:total] = total
  end

  def complete_checkout
    cart_items.each do |item|
      item.product.buy(item.quantity)
    end
  end
end
