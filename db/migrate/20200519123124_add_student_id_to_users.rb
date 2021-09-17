class AddStudentIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :student_id, :integer
  end
end
