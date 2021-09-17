class ChangeAreaTypeOfUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :area, :string
  end
end
