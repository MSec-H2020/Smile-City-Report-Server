class CreateOthersmiles < ActiveRecord::Migration[5.1]
  def change
    create_table :othersmiles do |t|
      t.integer :smile_id
      t.integer :user_id
      t.string :pic_path
      t.float :degree
      t.float :lat
      t.float :lon

      t.timestamps null: false
    end
  end
end
