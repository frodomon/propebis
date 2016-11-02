class CreateSalesOrderDetails < ActiveRecord::Migration
  def change
    create_table :sales_order_details do |t|
      t.references :sales_order, index: true
      t.references :product, index: true
      t.float :quantity
      t.float :unit_price
      t.float :subtotal

      t.timestamps null: false
    end
    add_foreign_key :sales_order_details, :sales_orders
    add_foreign_key :sales_order_details, :products
  end
end
