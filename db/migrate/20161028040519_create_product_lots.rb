class CreateProductLots < ActiveRecord::Migration
  def change
    create_table :product_lots do |t|
      t.float :quantity, :limit => 25
      t.string :sanitary_registry
      t.date :due_date
      t.string :lot_number
      t.date :production_date
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_lots, :products
  end
end
