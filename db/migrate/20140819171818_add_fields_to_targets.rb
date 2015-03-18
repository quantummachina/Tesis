class AddFieldsToTargets < ActiveRecord::Migration
  def change
  	add_column :targets, :retained, :boolean, default: false
  	add_column :targets, :since, :integer, default: 0
  	add_column :targets, :nlisted, :integer, default: 0
  	add_column :targets, :utcoffset, :integer, default: 0
  end
end
