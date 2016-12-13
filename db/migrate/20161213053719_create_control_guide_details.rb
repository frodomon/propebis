class CreateControlGuideDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :control_guide_details do |t|
      t.references :control_guide, index: true
      t.references :product, index: true
      t.float :quantity
      t.float :unit_price
      t.float :subtotal

      t.timestamps null: false
    end
    add_foreign_key :control_guide_details, :control_guides
    add_foreign_key :control_guide_details, :products
  end
end
