class CreateAddendumDetails < ActiveRecord::Migration
  def change
    create_table :addendum_details do |t|
      t.references :addendum, index: true
      t.references :product, index: true
      t.float :quantity
      t.float :unit_price
      t.float :subtotal

      t.timestamps null: false
    end
    add_foreign_key :addendum_details, :addendums
    add_foreign_key :addendum_details, :products
  end
end
