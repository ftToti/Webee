class CreateScouts < ActiveRecord::Migration[5.2]
  def change
    create_table :scouts do |t|
    	t.integer :user_id, null: false
    	t.integer :request_id, null: false
    	t.string :message

      t.timestamps
    end
  end
end
