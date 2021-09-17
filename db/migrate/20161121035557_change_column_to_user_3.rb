class ChangeColumnToUser3 < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :fbtoken, :string, :limit=>500
  end
end
