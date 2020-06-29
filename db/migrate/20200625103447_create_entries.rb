class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
    	t.integer :user_id, null: false
    	t.integer :request, null: false
    	t.string :message

      t.timestamps
    end
  end
end
