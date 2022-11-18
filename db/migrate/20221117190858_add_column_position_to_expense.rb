class AddColumnPositionToExpense < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :position, :integer
  end
end
