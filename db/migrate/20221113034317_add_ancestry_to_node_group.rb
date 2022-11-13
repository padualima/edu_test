class AddAncestryToNodeGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :node_groups, :ancestry, :string
    add_index :node_groups, :ancestry
  end
end
