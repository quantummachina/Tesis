class AddFrecuenciesToTargetsTargets2 < ActiveRecord::Migration
  def change
  	add_column :targets, :tfr, :float, default: 0.0
  	add_column :targets, :ffr, :float, default: 0.0
  	add_column :target2s, :tfr, :float, default: 0.0
  	add_column :target2s, :ffr, :float, default: 0.0
  end
end
