class Cart < ApplicationRecord
  include AASM

  has_many :cart_items

  before_save :update_total

  enum status: [:open, :checked_out]

  aasm column: :status do
    state :open, initial: true
    state :checked_out
  end

  def update_total
    total = cart_items.collect { |item| item.valid? ? (item.quantity * item.price) : 0}.sum
    self[:total] = total
  end
end
