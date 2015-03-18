class AddColumnsToTargets < ActiveRecord::Migration
  def change
  	add_column :targets, :spamed, :boolean, default: false
  end
end
