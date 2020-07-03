class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
    	t.integer :user_id, null: false
    	t.integer :request_id, null: false
    	t.integer :value
    	t.string :commnet
    	t.boolean :status, default: false

      t.timestamps
    end
  end
end
