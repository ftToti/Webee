class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
    	t.integer :visitor_id, null: false
    	t.integer :visited_id, null: false
    	t.integer :request_id, optional: true
    	t.integer :message_id, optional: true
    	t.integer :scout_id, optional: true
    	t.integer :entry_id, optional: true
    	t.string :action, null: false
    	t.boolean :checked, default: false

      t.timestamps
    end
  end
end
