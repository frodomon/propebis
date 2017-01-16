class CreatePurchaseOrderDetails < ActiveRecord::Migration
  def change
    create_table :purchase_order_details do |t|
      t.references :purchase_order, index: true
      t.references :product, index: true
      t.float :quantity
      t.float :pending
      t.float :unit_price
      t.float :subtotal

      t.timestamps null: false
    end
    add_foreign_key :purchase_order_details, :purchase_orders
    add_foreign_key :purchase_order_details, :products
  end
end
