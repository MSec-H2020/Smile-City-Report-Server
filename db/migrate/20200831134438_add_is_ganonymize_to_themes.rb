class AddIsGanonymizeToThemes < ActiveRecord::Migration[5.2]
  def change
    add_column :themes, :isGanonymize, :boolean, default: false, null: false
  end
end
