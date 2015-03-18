class CreateTarget2s < ActiveRecord::Migration
  def change
    create_table :target2s do |t|
		t.belongs_to :target
    	t.integer :uid, default: 0
    	t.string :name, default: ""
    	t.string :screen_name, default: ""
    	t.integer :nfollowers, default: 0
      	t.integer :nfriends, default: 0
      	t.float :f2f, default: 0
    	t.integer :nfavorites, default: 0
    	t.integer :ntweets, default: 0

    	t.boolean :spamed, default: false
    	t.boolean :retained, default: false
    	t.integer :since, default: 0
    	t.integer :nlisted, default: 0
    	t.integer :utcoffset, default: 0
    	t.integer :beak, default: 0

      	t.timestamps
    end
  end
end
