class AddUserRefToPointUses < ActiveRecord::Migration[5.2]
  def change
    add_reference :point_uses, :user, foreign_key: true
  end
end
