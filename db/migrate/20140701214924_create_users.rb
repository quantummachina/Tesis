class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.integer :uid, default: 0
    	t.string :name, default: ""
    	t.string :screen_name, default: ""
    	t.string :description, default: ""
      t.string :location, default: ""
    	t.integer :nfollowers, default: 0
    	t.integer :nfriends, default: 0
    	t.integer :nfavorites, default: 0
    	t.integer :ntweets, default: 0
      t.timestamps
    end
  end
end
