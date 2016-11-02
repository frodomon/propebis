class CreateRemissionGuideDetails < ActiveRecord::Migration
  def change
    create_table :remission_guide_details do |t|
      t.references :remission_guide, index: true
      t.references :product, index: true
      t.float :quantity

      t.timestamps null: false
    end
    add_foreign_key :remission_guide_details, :remission_guides
    add_foreign_key :remission_guide_details, :products
  end
end
