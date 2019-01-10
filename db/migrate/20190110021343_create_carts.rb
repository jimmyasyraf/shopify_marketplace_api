class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.decimal "total", precision: 20, scale: 3
      t.string "currency", limit: 3
      t.integer "status", default: 0

      t.timestamps
    end
  end
end
