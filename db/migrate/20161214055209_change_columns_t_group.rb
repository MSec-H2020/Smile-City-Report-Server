class ChangeColumnsTGroup < ActiveRecord::Migration[5.1]
  def change
    remove_column :groups, :user_id, :integer
    remove_column :smiles, :group_name, :string
  end
end
