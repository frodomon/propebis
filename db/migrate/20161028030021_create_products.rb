class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :unit_of_measurement
      t.string :description
      t.string :trademark
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
