class CreatePurchaseOrderDocuments < ActiveRecord::Migration
  def change
    create_table :purchase_order_documents do |t|
      t.references :purchase_order, index: true
      t.attachment :document

      t.timestamps null: false
    end
    add_foreign_key :purchase_order_documents, :purchase_orders
  end
end
