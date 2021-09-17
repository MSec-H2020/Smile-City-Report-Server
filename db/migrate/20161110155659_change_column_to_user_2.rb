class ChangeColumnToUser2 < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fbid, :string
  end
end
