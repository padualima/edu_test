class AddColumnExpenseCategoryToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :expense_category, null: false, foreign_key: true
  end
end
