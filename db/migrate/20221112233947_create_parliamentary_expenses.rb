class CreateParliamentaryExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :parliamentary_expenses do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :ide_document, limit: 15
      t.integer :subquota_number
      t.integer :subquota_specification_number
      t.string :description, null: false
      t.text :exact_description
      t.string :document_type, limit: 15
      t.integer :value_cents, null: false
      t.string :refund_value_cents
      t.string :refund_number
      t.string :lot_number, limit: 20
      t.string :reference_month, limit: 2
      t.string :reference_year, limit: 4
      t.date :issue_at, null: false

      t.timestamps
    end
  end
end
