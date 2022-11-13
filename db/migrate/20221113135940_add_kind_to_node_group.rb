class AddKindToNodeGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :node_groups, :kind, :integer, default: 0, limit: 1
  end
end
