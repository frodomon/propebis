class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :trademark

      t.timestamps null: false
    end
  end
end
