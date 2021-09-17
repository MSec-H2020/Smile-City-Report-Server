class AddUniqueIndexToReport < ActiveRecord::Migration[5.2]
  def change
    add_index :reports, [:user_id, :theme_id], unique: true
  end
end
