class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.references :node_group, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.string :uf, limit: 2
      t.string :parliamentary_number
      t.string :legislature, limit: 4
      t.string :legislature_code, limit: 10
      t.string :political_party, limit: 10

      t.timestamps
    end
  end
end
