class ChangeColumnKindToNodeGroup < ActiveRecord::Migration[7.0]
  def up
    change_column :node_groups, :kind, :integer, default: nil, limit: 1
  end

  def down
    change_column :node_groups, :kind, :integer, default: 0, limit: 1
  end
end
