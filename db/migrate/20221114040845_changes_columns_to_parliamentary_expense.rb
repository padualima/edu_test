class ChangesColumnsToParliamentaryExpense < ActiveRecord::Migration[7.0]
  def change
    remove_column :parliamentary_expenses, :subquota_number
    remove_column :parliamentary_expenses, :subquota_specification_number
    remove_column :parliamentary_expenses, :document_type
    remove_column :parliamentary_expenses, :refund_value_cents
    remove_column :parliamentary_expenses, :refund_number
    remove_column :parliamentary_expenses, :lot_number
    remove_column :parliamentary_expenses, :reference_month
    remove_column :parliamentary_expenses, :reference_year
    remove_column :parliamentary_expenses, :issue_at
    remove_column :parliamentary_expenses, :ide_document
    remove_column :parliamentary_expenses, :exact_description
    remove_column :parliamentary_expenses, :description
    remove_column :parliamentary_expenses, :company_id

    rename_column :parliamentary_expenses, :value_cents, :amount_cents
  end
end
