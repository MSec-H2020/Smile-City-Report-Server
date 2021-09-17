class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :smile_id
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
