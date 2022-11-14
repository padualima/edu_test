class ChangeColumnAmountCentsToExpense < ActiveRecord::Migration[7.0]
  def up
    change_column :expenses, :amount_cents, :integer, null: true
  end

  def down
    change_column :expenses, :amount_cents, :integer, null: false
  end
end
