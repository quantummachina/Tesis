class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :favsme, :integer, default: 0
  	add_column :users, :retsme, :integer, default: 0
  	add_column :users, :mentsme, :integer, default: 0
  end
end
