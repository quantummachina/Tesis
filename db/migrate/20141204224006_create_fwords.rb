class CreateFwords < ActiveRecord::Migration
  def change
    create_table :fwords do |t|
    	t.string :s, default: ''
    	t.integer :n, default: 0
      t.timestamps
    end
  end
end
