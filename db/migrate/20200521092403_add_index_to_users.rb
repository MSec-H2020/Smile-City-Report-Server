class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, [:student_id, :nickname], unique: true

  end
end
