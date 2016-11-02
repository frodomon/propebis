class CreateSalesOrderDocuments < ActiveRecord::Migration
  def change
    create_table :sales_order_documents do |t|
      t.references :sales_order, index: true
      t.attachment :document

      t.timestamps null: false
    end
    add_foreign_key :sales_order_documents, :sales_orders
  end
end
