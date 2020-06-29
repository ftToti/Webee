class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
    	t.integer :user_id, null: false
    	t.integer :room_id, null: false
    	t.string :message, null: false

      t.timestamps
    end
  end
end
