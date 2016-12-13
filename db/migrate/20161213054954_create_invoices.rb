class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.references :business, index: true
      t.references :client, index: true
      t.references :sales_order, index: true
      t.string :invoice_number
      t.date :date
      t.float :ammount

      t.timestamps null: false
    end

    add_foreign_key :invoices, :businesses
    add_foreign_key :invoices, :clients
    add_foreign_key :invoices, :sales_orders
  end
end
