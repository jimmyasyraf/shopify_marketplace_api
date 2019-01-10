class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :product, foreign_key: true
      t.references :cart, foreign_key: true
      t.decimal "price", precision: 20, scale: 3
      t.decimal "total", precision: 20, scale: 3
      t.string "currency", limit: 3
      t.integer :quantity

      t.timestamps
    end
  end
end
