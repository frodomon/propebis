class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :ruc
      t.string :address
      t.string :telephone
      t.string :contact
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
