class AddIndexToRequests < ActiveRecord::Migration[5.2]
  def change
  	add_index :requests, :title
  end
end
