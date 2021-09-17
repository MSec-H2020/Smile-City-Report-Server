class AddCaptionToSmile < ActiveRecord::Migration[5.2]
  def change
    add_column :smiles, :caption, :string
  end
end
