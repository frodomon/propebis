class CreateContractDocuments < ActiveRecord::Migration
  def change
    create_table :contract_documents do |t|
      t.references :contract, index: true
      t.attachment :document

      t.timestamps null: false
    end
    add_foreign_key :contract_documents, :contracts
  end
end
