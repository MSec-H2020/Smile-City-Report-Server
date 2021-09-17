class AddFacingToTheme < ActiveRecord::Migration[5.2]
  def change
    add_column :themes, :facing, :boolean
  end
end
