class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
    	t.integer :user_id, null: false
    	t.integer :request_genre_id, null: false
    	t.string :title, null: false
    	t.text :content, null: false
    	t.integer :reward, null: false
    	t.datetime :recruiment_end, null: false
    	t.datetime :delivery_date, null: false
    	t.datetime :completion
    	t.integer :recruiment_max, null: false
    	t.integer :status, null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
