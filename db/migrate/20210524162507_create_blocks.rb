class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.integer :blocked_by_user_id
      t.integer :block_user_id

      t.timestamps
    end
  end
end
