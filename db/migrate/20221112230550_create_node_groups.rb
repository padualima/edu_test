class CreateNodeGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :node_groups do |t|
      t.string :slug, limit: 4, null: false

      t.timestamps
    end
  end
end
