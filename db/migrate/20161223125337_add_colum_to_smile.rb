class AddColumToSmile < ActiveRecord::Migration[5.1]
  def change
    add_column :smiles, :back_pic_path, :string
  end
end
