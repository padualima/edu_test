class ChangeLimitAttributeToTables < ActiveRecord::Migration[7.0]
  def up
    change_column :members, :ide, :string, limit: 40
    change_column :portfolios, :legislature_code, :string, limit: 40
    change_column :portfolios, :political_party, :string, limit: 40
  end

  def down
    change_column :members, :ide, :string, limit: 10
    change_column :portfolios, :legislature_code, :string, limit: 10
    change_column :portfolios, :political_party, :string, limit: 10
  end
end
