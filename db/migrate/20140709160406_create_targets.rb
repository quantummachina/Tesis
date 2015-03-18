class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
    	t.belongs_to :user
    	t.integer :uid, default: 0
    	t.string :name, default: ""
    	t.string :screen_name, default: ""
    	t.integer :nfollowers, default: 0
      t.integer :nfriends, default: 0
      t.float :f2f, default: 0
    	t.integer :nfavorites, default: 0
    	t.integer :ntweets, default: 0
      t.timestamps
    end
  end
end
