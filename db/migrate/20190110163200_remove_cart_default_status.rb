class RemoveCartDefaultStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default( :carts, :status, from: 0, to: nil )
  end
end
