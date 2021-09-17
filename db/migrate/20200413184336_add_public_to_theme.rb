class AddPublicToTheme < ActiveRecord::Migration[5.2]
  def change
    add_column :themes, :public, :boolean
  end
end
