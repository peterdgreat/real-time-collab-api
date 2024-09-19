class CreateDocumentUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :document_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :document, null: false, foreign_key: true

      t.timestamps
    end
  end
end
