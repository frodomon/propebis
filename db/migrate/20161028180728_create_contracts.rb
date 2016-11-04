class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.references :client, index: true
      t.references :business, index: true
      t.string :contract_number
      t.date :date
      t.date :start_date
      t.date :end_date
      t.float :final_price
      t.float :credit
      t.boolean :active

      t.timestamps null: false
    end
    add_foreign_key :contracts, :clients
    add_foreign_key :contracts, :businesses
  end
end
