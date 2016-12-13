class CreateControlGuides < ActiveRecord::Migration[5.0]
  def change
    create_table :control_guides do |t|
      t.references :business, index: true
      t.references :client, index: true
      t.references :driver, index: true
      t.references :vehicle, index: true
      t.references :sales_order, index: true
      t.string :control_guide_number
      t.string :initial_point
      t.string :final_point
      t.date :date
      t.float :ammount

      t.timestamps null: false
    end

    add_foreign_key :control_guides, :businesses
    add_foreign_key :control_guides, :clients
    add_foreign_key :control_guides, :drivers
    add_foreign_key :control_guides, :vehicles
    add_foreign_key :control_guides, :sales_orders
  end
end
