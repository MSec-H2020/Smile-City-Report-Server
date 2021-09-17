class AddColumnToOthersmile01 < ActiveRecord::Migration[5.2]
  def change
    add_column :othersmiles, :first_degree, :float
    add_column :othersmiles, :max_degree, :float
    rename_column :othersmiles, :degree, :diff_degree
  end
end
