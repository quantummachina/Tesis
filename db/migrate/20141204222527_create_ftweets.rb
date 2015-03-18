class CreateFtweets < ActiveRecord::Migration
  def change
    create_table :ftweets do |t|
    	t.integer :tid, default: 0
    	t.string :text, default: ''
      t.timestamps
    end
  end
end
