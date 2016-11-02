class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :ruc
      t.string :billing_address
      t.string :delivery_address
      t.string :telephone
      t.string :contact
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
