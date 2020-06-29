class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
    	t.integer :visitor_id, null: false
    	t.integer :visited_id, null: false
    	t.integer :request_id
    	t.integer :favorite_id
    	t.integer :talk_id
    	t.integer :scout_id
    	t.integer :entry_id
    	t.integer :action, null: false
    	t.boolean :checked, default: false

      t.timestamps
    end
  end
end
