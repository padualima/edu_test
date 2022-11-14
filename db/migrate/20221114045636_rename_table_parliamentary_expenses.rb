class RenameTableParliamentaryExpenses < ActiveRecord::Migration[7.0]
  def change
    rename_table :parliamentary_expenses, :expenses
  end
end
