class CreateSmiles < ActiveRecord::Migration[5.1]
  def change
    create_table :smiles do |t|
      t.integer :user_id
      t.string :group_name
      t.string :pic_path
      t.float :degree
      t.float :lat
      t.float :lon

      t.timestamps null: false
    end
  end
end
