class AddF2fToUsers < ActiveRecord::Migration
  def change
  	
  	add_column :users, :f2f, :float, default: 0
  	
  end
end
