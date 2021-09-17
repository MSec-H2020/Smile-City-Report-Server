class AddColumnToOthersmile < ActiveRecord::Migration[5.1]
  def change
    add_column :othersmiles, :mode, :integer
  end
end
