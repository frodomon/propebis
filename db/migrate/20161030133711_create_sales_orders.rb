class CreateSalesOrders < ActiveRecord::Migration
  def change
    create_table :sales_orders do |t|
      t.references :business, index: true
      t.references :client, index: true
      t.references :contract, index: true
      t.string :sales_order_number
      t.date :date
      t.string :billing_address
      t.string :delivery_address
      t.date :order_date
      t.date :delivery_date
      t.float :ammount

      t.timestamps null: false
    end
    add_foreign_key :sales_orders, :businesses
    add_foreign_key :sales_orders, :clients
    add_foreign_key :sales_orders, :contracts
  end
end
