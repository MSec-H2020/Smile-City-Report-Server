class AddOwnerRefToTheme < ActiveRecord::Migration[5.2]
  def change
    add_reference :themes, :owner, foreign_key: {to_table: :users}
  end
end
