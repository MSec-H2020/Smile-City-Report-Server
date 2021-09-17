class CreateSmileGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :smile_groups do |t|
      t.integer :smile_id
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
