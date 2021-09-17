class AddDegreeToOthersmiles < ActiveRecord::Migration[5.2]
  def change
    add_column :othersmiles, :degree, :float
  end
end
