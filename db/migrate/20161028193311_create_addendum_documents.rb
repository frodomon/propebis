class CreateAddendumDocuments < ActiveRecord::Migration
  def change
    create_table :addendum_documents do |t|
      t.references :addendum, index: true
      t.attachment :document

      t.timestamps null: false
    end
    add_foreign_key :addendum_documents, :addendums
  end
end
