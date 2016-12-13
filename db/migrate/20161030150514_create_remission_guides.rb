class CreateRemissionGuides < ActiveRecord::Migration
  def change
    create_table :remission_guides do |t|
      t.references :business, index: true
      t.references :client, index: true
      t.references :driver, index: true
      t.references :vehicle, index: true
      t.references :sales_order, index: true
      t.string :remission_guide_number
      t.string :initial_point
      t.string :final_point
      t.date :date
      t.float :ammount

      t.timestamps null: false
    end
    
    add_foreign_key :remission_guides, :businesses
    add_foreign_key :remission_guides, :clients
    add_foreign_key :remission_guides, :drivers
    add_foreign_key :remission_guides, :vehicles
    add_foreign_key :remission_guides, :sales_orders
  end
end
