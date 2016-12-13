class CreateInvoiceDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_details do |t|
      t.references :invoice, index: true
      t.references :product, index: true
      t.float :quantity
      t.float :unit_price
      t.float :subtotal

      t.timestamps null: false
    end
    add_foreign_key :invoice_details, :invoices
    add_foreign_key :invoice_details, :products
  end
end
