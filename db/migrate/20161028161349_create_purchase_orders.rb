class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.references :supplier, index: true
      t.references :business, index: true
      t.string :order_number
      t.date :date
      t.date :order_date
      t.date :delivery_date
      t.string :billing_address
      t.string :delivery_address
      t.float :ammount
      t.boolean :registered, default: false

      t.timestamps null: false
    end
    add_foreign_key :purchase_orders, :suppliers
    add_foreign_key :purchase_orders, :businesses
  end
end
