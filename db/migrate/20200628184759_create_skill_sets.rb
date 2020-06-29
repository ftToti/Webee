class CreateSkillSets < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_sets do |t|
    	t.integer :possible_id
    	t.integer :good_id
    	t.integer :necessary_id
    	t.integer :skill_id, null: false

      t.timestamps
    end
  end
end
