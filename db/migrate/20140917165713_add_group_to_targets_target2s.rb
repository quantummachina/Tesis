class AddGroupToTargetsTarget2s < ActiveRecord::Migration
  def change
  	add_column :targets, :group, :integer, default: 0
  	add_column :target2s, :group, :integer, default: 0
  end
end
