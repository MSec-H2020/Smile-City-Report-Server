class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :group_name

      t.timestamps null: false
    end
  end
end
