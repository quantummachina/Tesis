class Cart < ActiveRecord::Migration
  def change
  	create_table :carts do |t|
		t.integer :user_id 
		t.integer :target_id
      	t.timestamps
      end
  end
end
