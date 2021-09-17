class AddAreaToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :area, :integer, default: 0, null: false
  end
end
