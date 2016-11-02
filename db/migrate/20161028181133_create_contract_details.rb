class CreateContractDetails < ActiveRecord::Migration
  def change
    create_table :contract_details do |t|
      t.references :contract, index: true
      t.references :product, index: true
      t.float :quantity
      t.float :unit_price
      t.float :subtotal

      t.timestamps null: false
    end
    add_foreign_key :contract_details, :contracts
    add_foreign_key :contract_details, :products
  end
end
