class AddColumnPositionToPortfolio < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :position, :integer
  end
end
