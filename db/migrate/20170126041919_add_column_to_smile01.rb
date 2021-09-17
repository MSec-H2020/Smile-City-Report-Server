class AddColumnToSmile01 < ActiveRecord::Migration[5.1]
  def change
    add_column :smiles, :mode, :integer
  end
end
