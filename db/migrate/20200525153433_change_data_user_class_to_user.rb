class ChangeDataUserClassToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :user_class, :string
  end
end
