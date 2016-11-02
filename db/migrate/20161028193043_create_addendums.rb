class CreateAddendums < ActiveRecord::Migration
  def change
    create_table :addendums do |t|
      t.references :contract, index: true
      t.string :addendum_number
      t.float :ammount
      t.date :date
      t.boolean :updated, default: false

      t.timestamps null: false
    end
    add_foreign_key :addendums, :contracts
  end
end
