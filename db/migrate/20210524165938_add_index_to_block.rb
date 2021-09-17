class AddIndexToBlock < ActiveRecord::Migration[5.2]
  def change
    add_index :blocks, [:blocked_by_user_id, :block_user_id], unique: true
  end
end
