class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :view
      t.string :state
      t.float :version

      t.timestamps null: false
    end
  end
end
