class AddExpensesAmountToPortfolio < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :expenses_amount_cents, :integer
  end
end
