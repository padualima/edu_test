class CreateExpenseCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_companies do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :ide_document
      t.string :description
      t.string :exact_description
      t.integer :value_cents
      t.date :issued_at

      t.timestamps
    end
  end
end
